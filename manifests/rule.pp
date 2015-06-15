#iproute2 rule
define iproute2::rule(
  $source,
  $device,
  $table = 'main',
) {

  ensure_resource('concat', "/etc/sysconfig/network-scripts/rule-${device}", {'ensure' => 'present'})

  concat::fragment { "rule_fragment_${name}":
    target  => "/etc/sysconfig/network-scripts/rule-${device}",
    content => "from ${source} table ${table}\n",
    require => Iproute2::Rt_table[$table],
  }

}
