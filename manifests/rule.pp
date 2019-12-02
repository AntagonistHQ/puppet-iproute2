#iproute2 rule
define iproute2::rule(
  Stdlib::IP::Address $source,
  String $device,
  String $table = 'main',
) {

  $rulefile = $source ? {
    Stdlib::IP::Address::V4::CIDR => 'rule',
    Stdlib::IP::Address::V6::CIDR => 'rule6',
    default                 => fail('Source address needs to be IPv4 or IPv6 CIDR'),
  }

  ensure_resource('concat', "/etc/sysconfig/network-scripts/${rulefile}-${device}", {'ensure' => 'present'})

  concat::fragment { "${rulefile}_fragment_${name}":
    target  => "/etc/sysconfig/network-scripts/${rulefile}-${device}",
    content => "from ${source} table ${table}\n",
    require => Iproute2::Rt_table[$table],
  }

}
