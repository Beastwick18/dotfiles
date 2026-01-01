$env.XDG_CONFIG_HOME = $"($env.HOME)/.config"
$env.XDG_STATE_HOME = $"($env.HOME)/.local/state"
$env.XDG_DATA_HOME = $"($env.HOME)/.local/share"
$env.XDG_CACHE_HOME = $"($env.HOME)/.cache"

$env.PATH = ($env.PATH | split row (char esep) | prepend [$"($env.HOME)/.local/bin/dotbin", $"($env.HOME)/.local/bin", $"($env.HOME)/.local/share/cargo/bin"])
$env.STARSHIP_CONFIG = $"($env.HOME)/.config/starship/starship.toml"
$env.WALLPAPERS_DIR = $"($env.HOME)/Pictures/wallpapers"
$env.EDITOR = "nvim"

$env.CARGO_HOME = $"($env.XDG_DATA_HOME)/cargo" # cargo
$env.CUDA_CACHE_PATH = $"($env.XDG_CACHE_HOME)/nv"
$env.DOTNET_CLI_HOME = $"($env.XDG_DATA_HOME)/dotnet"
$env.GNUPGHOME = $"($env.XDG_DATA_HOME)/gnupg"
$env.RUSTUP_HOME = $"($env.XDG_DATA_HOME)/rustup"
$env.NUGET_PACKAGES = $"($env.XDG_CACHE_HOME)/NuGetPackages"
$env.WGETRC = $"($env.XDG_CONFIG_HOME)/wgetrc"
$env._JAVA_OPTIONS = "-Djava.util.prefs.userRoot=\"$XDG_CONFIG_HOME\"/java"
$env.GOPATH = $"($env.XDG_DATA_HOME)/go"
$env.GOMODCACHE = $"($env.XDG_CACHE_HOME)/go/mod"
$env.NPM_CONFIG_USERCONFIG = $"($env.XDG_CONFIG_HOME)/npm/npmrc"
