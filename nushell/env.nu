$env.XDG_CONFIG_HOME = $"($env.HOME)/.config"
$env.XDG_STATE_HOME = $"($env.HOME)/.local/state"
$env.XDG_DATA_HOME = $"($env.HOME)/.local/share"
$env.XDG_CACHE_HOME = $"($env.HOME)/.cache"

$env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.local/bin/dotbin" | prepend $"($env.HOME)/.local/bin")
$env.STARSHIP_CONFIG = $"($env.HOME)/.config/starship/starship.toml"
$env.WALLPAPERS_DIR = $"($env.HOME)/Pictures/wallpapers"
$env.EDITOR = "nvim"

