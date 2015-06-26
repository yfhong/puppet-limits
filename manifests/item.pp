# == Define limits::item
#
# This define is called from limits::domain for limits item setting.
#
# Example:
#  limits::item { 'defaults-nofile':
#    domain => '*',
#    type   => 'hard',
#    item   => 'nofile',
#    value  => '65535',
# }
#
define limits::item (
  $domain = undef,
  $item   = undef,
  $soft   = undef,
  $hard   = undef,
) {

  unless ($domain and $item and ($soft or $hard)) {
    fail("Every item must take at least 3 parameters.")
  }

  if ($soft) {
    limits::entry { "${domain}-soft-${item}":
      domain => "${domain}",
      type   => 'soft',
      item   => "${item}",
      value  => "${soft}",
    }
  }

  if ($hard) {
    limits::entry { "${domain}-hard-${item}":
      domain => "${domain}",
      type   => 'hard',
      item   => "${item}",
      value  => "${hard}",
    }
  }
}
