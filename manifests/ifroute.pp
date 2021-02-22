#iproute2 ifroute
define iproute2::ifroute(
  Stdlib::IP::Address $subnet,
  String $device,
  String $table = 'main',
) {

  $routefile = $gateway ? {
    Stdlib::IP::Address::V4 => 'route',
    Stdlib::IP::Address::V6 => 'route6',
    default                 => fail('Gateway address needs to be IPv4 or IPv6'),
  }

  ensure_resource('concat', "/etc/sysconfig/network-scripts/${routefile}-${device}", {'ensure' => 'present'})

  concat::fragment { "${routefile}_fragment_${name}":
    target  => "/etc/sysconfig/network-scripts/${routefile}-${device}",
    content => "${subnet} dev ${device} table ${table}\n",
    require => Iproute2::Rt_table[$table],
  }

}
