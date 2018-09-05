# Configures fail2ban
class fail2ban {

  package { 'fail2ban':
    ensure => installed,
    notify => Service['fail2ban'],
  }

  service { 'fail2ban':
    ensure    => running,
    subscribe => Package['fail2ban'],
    require   => File['/etc/fail2ban/jail.local', '/etc/fail2ban/fail2ban.local'],
  }

  file { '/etc/fail2ban/jail.local':
    source  => 'puppet:///modules/fail2ban/jail.local',
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['fail2ban'],
    notify  => Service['fail2ban'],
  }

  file { '/etc/fail2ban/fail2ban.local':
    source  => 'puppet:///modules/fail2ban/fail2ban.local',
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['fail2ban'],
    notify  => Service['fail2ban'],
  }
}
