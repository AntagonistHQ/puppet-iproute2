#iproute2 route
define iproute2::route(
  String $device,
  Optional[Stdlib::IP::Address] $gateway = undef,
  Optional[Stdlib::IP::Address] $subnet = undef,
  String $table = 'main',
) {
  if $gateway == undef and $subnet == undef {
    fail('At least one of gateway|subnet must be set')
  }

  if ($gateway =~ Stdlib::IP::Address::V6 or $subnet =~ Stdlib::IP::Address::V6) {
    $routefile = 'route6'
  } else {
    $routefile = 'route'
  }

  ensure_resource('concat', "/etc/sysconfig/network-scripts/${routefile}-${device}", {'ensure' => 'present'})

  if $subnet {
    $realsubnet = $subnet
  } else {
    $realsubnet = 'default'
  }
  if $gateway {
    $realgateway = " via ${gateway}"
  } else {
    $realgateway = ""
  }

  concat::fragment { "${routefile}_fragment_${name}":
    target  => "/etc/sysconfig/network-scripts/${routefile}-${device}",
    content => "${realsubnet}${realgateway} dev ${device} table ${table}\n",
    require => Iproute2::Rt_table[$table],
  }

}
