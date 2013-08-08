# == Class: vmwaretools::timesync
#
# This class handles synchronising the node's clock with vSphere
#
# == Actions:
#
# Either enables or disables timesync
#
# === Authors:
#
# Craig Watson <craig@cwatson.org>
#
# === Copyright:
#
# Copyright (C) 2013 Craig Watson
# Published under the GNU General Public License v3
#
class vmwaretools::timesync {

  $cmd_grep   = $vmwaretools::timesync ? {
    true    => 'Disabled'
    false   => 'Enabled'
    default => { fail "Unsupported value ${vmwaretools::timesync} for vmwaretools::timesync." }
  }

  $cmd_action   = $vmwaretools::timesync ? {
    true    => 'enable'
    false   => 'disable'
    default => { fail "Unsupported value ${vmwaretools::timesync} for vmwaretools::timesync." }
  }

  exec { "vmwaretools_timesync_${cmd_action}":
    command => "/usr/bin/vmware-toolbox-cmd timesync ${cmd_action}",
    onlyif  => "/usr/bin/vmware-toolbox-cmd timesync status | grep ${cmd_grep}"
  }

}
