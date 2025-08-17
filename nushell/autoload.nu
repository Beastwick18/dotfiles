# --- Autoload --- #
# Create autoload folder
mkdir ($nu.data-dir | path join "vendor/autoload")

# Setup starship
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# Setup zoxide
# [Broken for now]
# zoxide init nushell --cmd cd | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")
