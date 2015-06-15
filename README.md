#puppet-iproute2

####Table of Contents

1. [Overview](#overview)
4. [Usage](#usage)
5. [Operating Systems Support](#operating-systems-support)
6. [Development](#development)

##Overview

This module configures iproute2 on Red Hat based systems. At the moment it focusses on simple source based routing but can easily be extended.

##Usage

  iproute2::rt_table { 'table1':
    number => 10,
  }

  iproute2::rt_table { 'table2':
    number => 20,
  }

  iproute2::route { 'def_route_table1':
    gateway => '192.168.0.1',
    device  => 'eth0',
    table   => 'hosting1',
  }

  iproute2::route { 'def_route_table2':
    gateway => '10.0.0.1',
    device  => 'eth1',
    table   => 'hosting2',
  }

  iproute2::rule { 'def_route_table1':
    source => '192.168.0.0/24',
    device => 'eth0',
    table  => 'table1',
  }

  iproute2::rule { 'def_route_table2':
    source => '10.0.0.0/22',
    device => 'eth1',
    table  => 'table2',
  }



##Operating Systems Support

This is tested on these OS:
- CentOS 6

##Development

Pull requests (PR) and bug reports via GitHub are welcomed.
