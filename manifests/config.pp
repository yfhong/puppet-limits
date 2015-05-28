# == Class limits::config
#
# This class is called from limits for service config.
#
class limits::config {

  validate_array($::limits::options)
  $lines = $::limits::options

  file { $::limits::confdir:
    ensure => 'directory',
  }

  file { $::limits::customized_file:
    ensure  => 'present',
    owner   => 'root',
    group   => $::limits::params::root_group,
    mode    => '0640',
    content => template('limits/99-customization.conf.erb'),
  }
}
