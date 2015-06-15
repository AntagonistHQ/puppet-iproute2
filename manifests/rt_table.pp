#rt_tables entry
define iproute2::rt_table($number) {
  include iproute2

  concat::fragment{ "rt_tables_fragment_${name}":
    target  => '/etc/iproute2/rt_tables',
    order   => $number,
    content => "${number}\t${name}\n",
  }
}
