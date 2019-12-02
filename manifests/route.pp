#iproute2 route
define iproute2::route(
  Stdlib::IP::Address $gateway,
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
    content => "default via ${gateway} dev ${device} table ${table}\n",
    require => Iproute2::Rt_table[$table],
  }

}
