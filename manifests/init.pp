class fail2ban {

  package { 'fail2ban':
    ensure => installed,
    notify => Service['fail2ban'],
  }

  case $::lsbdistcodename {
    precise: { $fail2banconf='fail2ban.conf' $jailconf='jail.conf' }
    trusty:  { $fail2banconf='fail2ban.local' $jailconf='jail.local' }
    xenial:  { $fail2banconf='fail2ban.local' $jailconf='jail.local' }
    default: { fail("Unknown lsbdistcodename : '$::{lsbdistcodename}'") }
  }

  file { ['/etc/fail2ban/fail2ban.conf.local','/etc/fail2ban/jail.conf.local']:
    ensure => absent,
  }

  service { 'fail2ban':
    ensure    => running,
    subscribe => Package['fail2ban'],
    require   => File["/etc/fail2ban/$jailconf", "/etc/fail2ban/$fail2banconf"],
  }

  file { "/etc/fail2ban/$jailconf":
    source  => "puppet:///modules/fail2ban/$jailconf",
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['fail2ban'],
  }

  file { "/etc/fail2ban/$fail2banconf":
    source  => "puppet:///modules/fail2ban/$fail2banconf",
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['fail2ban'],
  }

  # This can be removed once we have run this on all hosts once
  # It just restores the original distro file for trusty
  if $::lsbdistcodename == 'trusty' {
    file { "/etc/fail2ban/jail.conf":
      source  => "puppet:///modules/fail2ban/jail.conf-trusty",
      owner   => root,
      group   => root,
      mode    => '0644',
      require => Package['fail2ban'],
    }

    file { "/etc/fail2ban/fail2ban.conf":
      source  => "puppet:///modules/fail2ban/fail2ban.conf-trusty",
      owner   => root,
      group   => root,
      mode    => '0644',
      require => Package['fail2ban'],
    }
  }
}
