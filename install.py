#!/bin/python3

import json
import os
from pathlib import Path

def create_link(name):
    if name not in cfg:
        print(f"{name}: Unknown name")
        return

    src = Path(name).expanduser().absolute()
    dst = Path(cfg[name]).expanduser().absolute()
    if dst.is_symlink():
        print(f"{name}: Link already exists")
        return
    if not src.exists():
        print(f"{name}: Does not exist")
        return

    ans = input(f"Link {name} -> {cfg[name]} [y/N] ")
    if ans.lower().strip() != "y":
        return

    if dst.exists():
        try:
            new_path = dst.replace(dst.with_name(src.name + ".bak"))
        except:
            print(f"{name}: Path exists, but unable to create backup")
            return
        print(f"Created backup for {name} located at {new_path}")

    try:
        dst.symlink_to(src, target_is_directory=src.is_dir())
    except:
        print(f"{name}: Unable to create symlink")

def load_map(filename):
    with open(filename) as file:
        return json.load(file)

def main():
    global cfg
    cfg = load_map("map.json")
    for k in cfg:
        create_link(k)

if __name__ == "__main__":
    main()
