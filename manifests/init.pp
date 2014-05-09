class fail2ban {

  package { 'fail2ban':
    ensure => installed,
    notify => Service['fail2ban'],
  }

  service { 'fail2ban':
    ensure    => running,
    subscribe => Package['fail2ban'],
    require   => File['/etc/fail2ban/jail.conf', '/etc/fail2ban/fail2ban.conf'],
  }

  file { '/etc/fail2ban/jail.conf':
    source  => 'puppet:///modules/fail2ban/jail.conf',
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['fail2ban'],
  }

  file { '/etc/fail2ban/fail2ban.conf':
    source  => 'puppet:///modules/fail2ban/fail2ban.conf',
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['fail2ban'],
  }
}
