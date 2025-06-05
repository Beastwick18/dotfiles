import tomllib


def read_config():
    with open("./dotfiles.toml", "rb") as f:
        return tomllib.load(f)


def main():
    config = read_config()
    print(config)


if __name__ == "__main__":
    main()
