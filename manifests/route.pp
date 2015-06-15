#iproute2 route
define iproute2::route(
  $gateway,
  $device,
  $table = 'main',
) {

  ensure_resource('concat', "/etc/sysconfig/network-scripts/route-${device}", {'ensure' => 'present'})

  concat::fragment { "route_fragment_${name}":
    target  => "/etc/sysconfig/network-scripts/route-${device}",
    content => "default via ${gateway} dev ${device} table ${table}\n",
    require => Iproute2::Rt_table[$table],
  }

}
