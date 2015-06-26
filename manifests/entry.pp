# == Define limits::entry
#
# This define is called from limits::setting for limits entry setting.
#
# Changes:
# modified only match to 'size == 0'
#
# Example:
#  limits::entry { 'defaults-hard-nofile':
#    domain => '*',
#    type   => 'hard',
#    item   => 'nofile',
#    value  => '65535',
# }
#
define limits::entry (
  $domain = undef,
  $type   = undef,
  $item   = undef,
  $value  = undef,
) {

  unless ($domain and $type and $item and $value) {
    fail("Every entry must take all 4 parameters.")
  }

  case $item {
    'core': {}
    'data': {}
    'fsize': {}
    'memlock': {}
    'nofile': {}
    'rss': {}
    'stack': {}
    'cpu': {}
    'nproc': {}
    'as': {}
    'maxlogins': {}
    'maxsyslogins': {}
    'priority': {}
    'locks': {}
    'sigpending': {}
    'msqqueue': {}
    'nice': {}
    'rtprio': {}
    default: {
      fail("Unknown item '$item', see the limits.conf man page for valid values")
    }
  }

  # unique namevar for this entry
  $entry_name = "limits_entry-${domain}-${type}-${item}"

  # context, path to target file with '/files' prepended.
  $context = "/files${::limits::customized_file}"

  # path for exists checking
  $path_without_value = "domain[.='${domain}'][./type='${type}' and ./item='${item}']"
  # path for setting
  $path_with_value = "domain[.='${domain}'][./type='${type}' and ./item='${item}' and ./value='${value}']"

  augeas { "${entry_name}":
    context => $context,
    onlyif  => "match ${path_with_value} size == 0",
    changes => [
                # remove all matching
                "rm ${path_without_value}",
                # add new entry
                "set domain[last()+1] ${domain}",
                "set domain[last()]/type ${type}",
                "set domain[last()]/item ${item}",
                "set domain[last()]/value ${value}",
                ],
  }
}
