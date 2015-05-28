# == Class limits::params
#
# This class is meant to be called from limits.
# It sets variables according to platform.
#
class limits::params {

  $confdir = '/etc/security/limits.d'
  $conffile = '/etc/security/limits.conf'
  $customized_file = "${confdir}/99-customization.conf"

  case $::operatingsystem {
    'Debian', 'Ubuntu',
    'RedHat', 'CentOS',
    'Amazon': {
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
