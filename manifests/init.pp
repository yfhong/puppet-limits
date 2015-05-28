# == Class: limits
#
# Full description of class limits here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
# limits::options
#   default_hard_nofile:
#    domain: '*'
#    type: 'hard'
#    item: 'nofile'
#    value: '0'
####
class limits (
  $confdir         = $::limits::params::confdir,
  $conffile        = $::limits::params::conffile,
  $customized_file = $::limits::params::customized_file,
  $options,
) inherits ::limits::params {

  # validate parameters here

  class { '::limits::config': } ~>
  Class['::limits']
}
