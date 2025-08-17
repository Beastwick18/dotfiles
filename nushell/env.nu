$env.XDG_CONFIG_HOME = $"($env.HOME)/.config"
$env.XDG_STATE_HOME = $"($env.HOME)/.local/state"
$env.XDG_DATA_HOME = $"($env.HOME)/.local/share"
$env.XDG_CACHE_HOME = $"($env.HOME)/.cache"

$env.PATH = ($env.PATH | split row (char esep) | prepend [$"($env.HOME)/.local/bin/dotbin", $"($env.HOME)/.local/bin", $"($env.HOME)/.local/share/cargo/bin"])
$env.STARSHIP_CONFIG = $"($env.HOME)/.config/starship/starship.toml"
$env.WALLPAPERS_DIR = $"($env.HOME)/Pictures/wallpapers"
$env.EDITOR = "nvim"

# XDG-ninja
$env.CARGO_HOME = $"($env.XDG_DATA_HOME)/cargo" # cargo
$env.CUDA_CACHE_PATH = $"($env.XDG_CACHE_HOME)/nv"
$env.DOTNET_CLI_HOME = $"($env.XDG_DATA_HOME)/dotnet"
$env.GNUPGHOME = $"($env.XDG_DATA_HOME)/gnupg"
$env.RUSTUP_HOME = $"($env.XDG_DATA_HOME)/rustup"
$env.NUGET_PACKAGES = $"($env.XDG_CACHE_HOME)/NuGetPackages"
