#
# = Class: iproute2
#
# This class installs and manage iproute2 configuration files
#

class iproute2 {

  concat { '/etc/iproute2/rt_tables':
    owner => 'root',
    group => 'root',
    mode  => '0644'
  }

  concat::fragment{ 'rt_tables_header':
    target  => '/etc/iproute2/rt_tables',
    content => "#\n# reserved values\n#\n255 local\n254 main\n253 default\n0 unspec\n#\n# local\n#\n",
    order   => 0,
  }
}
