class baseconfig {
  exec { 'actualizando linux':
    command   => '/usr/bin/apt-get update && /usr/bin/apt-get -y upgrade',
    path      => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    logoutput => true,
    notify    => Exec['instalando lxd'],
  }

  exec { 'instalando lxd':
    command   => '/usr/bin/apt-get install lxd -y && /usr/bin/newgrp lxd',
    path      => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    logoutput => true,
    require   => Exec['actualizando linux'],
    notify    => Exec['inicializando lxd'],
  }

  exec { 'inicializando lxd':
    command   => 'lxd init --auto',
    path      => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    logoutput => true,
    require   => Exec['instalando lxd'],
    notify    => Exec['creando contenedores'],
  }

  exec { 'creando contenedores':
    command   => '/usr/bin/lxc launch ubuntu:18.04 web1 && /usr/bin/lxc launch ubuntu:18.04 web2',
    path      => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    logoutput => true,
    require   => Exec['inicializando lxd'],
    notify    => Exec['instalando apache'],
    unless    => '/usr/bin/lxc list | /bin/grep -q web2',
  }


  exec { 'instalando apache':
    command   => '/usr/bin/lxc exec web1 -- /usr/bin/apt-get update && /usr/bin/lxc exec web1 -- /usr/bin/apt-get -y install apache2 && /usr/bin/lxc exec web1 -- /bin/systemctl enable apache2 && /usr/bin/lxc exec web1 -- /bin/systemctl start apache2 && /usr/bin/lxc exec web2 -- /usr/bin/apt-get update && /usr/bin/lxc exec web2 -- /usr/bin/apt-get -y install apache2 && /usr/bin/lxc exec web2 -- /bin/systemctl enable apache2 && /usr/bin/lxc exec web2 -- /bin/systemctl start apache2',
    path      => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    logoutput => true,
    require   => Exec['creando contenedores'],
  }


  exec { 'creando contenedor haproxy':
    command   => '/usr/bin/lxc launch ubuntu:18.04 haproxy',
    path      => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    logoutput => true,
    unless    => '/usr/bin/lxc list | /bin/grep -q haproxy',
  }

  exec { 'actualizando contenedor haproxy':
  command   => '/usr/bin/lxc exec haproxy -- /usr/bin/apt-get update && /usr/bin/lxc exec haproxy -- /bin/systemctl daemon-reload',
  path      => ['/usr/bin','/usr/sbin','/bin','/sbin'],
  logoutput => true,
  timeout   => 600,
  provider  => 'shell',
  refreshonly => true,
  }


  exec { 'instalando haproxy':
    command   => '/usr/bin/lxc exec haproxy -- /usr/bin/apt-get -y --fix-missing install haproxy && /usr/bin/lxc exec haproxy -- /bin/systemctl enable haproxy && /usr/bin/lxc exec haproxy -- /bin/systemctl start haproxy',
    path      => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    logoutput => true,
    require   => Exec['actualizando contenedor haproxy'],
    unless    => '/usr/bin/lxc exec haproxy -- /usr/bin/dpkg -l haproxy | /bin/grep -q ii',
  }





}
