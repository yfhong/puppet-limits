# == Class limits::config
#
# This class is called from limits for service config.
#
class limits::config {

  $entries = hiera_hash('limits::entries', undef)

  if ($entries) {
    validate_hash($entries)
    create_resources('limits::domain', $entries)
  }
}
