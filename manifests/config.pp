# == Class limits::config
#
# This class is called from limits for service config.
#
# limits::entries:
#   '*-nofile':
#     hard: 51200
#     soft: 51200
#   '*-core':
#     hard: 51200
#     soft: 51200
#   'root-core':
#     hard: 10000
#     soft: 10000
class limits::config {

  $entries = hiera_hash('limits::entries', undef)

  if ($entries) {
    validate_hash($entries)
    create_resources('limits::set', $entries)
  }
}
