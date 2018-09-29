function prepend_paths
    contains -- $argv $PATH
      or set -gx PATH $argv $PATH
end
