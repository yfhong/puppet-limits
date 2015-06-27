# == Define limits::set
#
# This define is called from limits::config for limits domain setting.
#
# Example:
#  limits::set { '*-nofile':
#    hard => '1000',
#    soft => '1000',
# }
#
define limits::set (
  $hard = undef,
  $soft = undef,
) {

  $domain_item_array = split($title, '-')
  $domain = $domain_item_array[0]
  $item = $domain_item_array[1]

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
