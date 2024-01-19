#!/bin/python3

import json
import os
import sys
import subprocess
import time
from pathlib import Path

def print_help():
    print("Usage: dot <action>")
    print("Actions:")
    print("  install: Install dotfiles by creating symlinks")
    print("  sync: Sync dotfiles with remote")

def install(exe, cwd):
    os.chdir(exe)
    global cfg
    cfg = load_map("dotfiles.json")
    for k in cfg:
        create_link(k)
    os.chdir(cwd)

def sync(exe, cwd):
    os.chdir(exe)
    date = time.strftime("%m-%d-%y %H:%M:%S")
    print(date)
    subprocess.run(["git", "pull", "--rebase"])
    subprocess.run(["git", "add", "--all"])
    subprocess.run(["git", "commit", "-m", date])
    subprocess.run(["git", "push"])
    os.chdir(cwd)

def add(arg, exe, cwd):
    if len(arg) < 2:
        print("Usage: dot add <path>")
        return
    orig = Path(arg[1]).expanduser().absolute()
    dotfile = exe.joinpath(orig.name)
    print(orig)
    print(dotfile)
    print(f"mv {orig} -> {dotfile}")


def main(arg):
    # Navigate to target of dot.py symlink
    # All dotfiles are located here
    cwd = Path.cwd().expanduser().absolute()
    exe = Path(arg[0]).expanduser().absolute()
    if exe.is_symlink():
        exe = exe.readlink().parent.absolute()
    else:
        exe = exe.parent.absolute()

    if len(arg) < 2 or arg[1] == "sync":
        sync(exe, cwd)
    elif arg[1] == "install":
        install(exe, cwd)
    elif arg[1] == "add":
        add(arg[1:], exe, cwd)
    else:
        print_help()

def create_link(name):
    if name not in cfg:
        print(f"{name}: Unknown name")
        return

    dst = Path(cfg[name]).expanduser().absolute()
    if dst.is_symlink():
        print(f"{name}: Link already exists")
        return

    src = Path(name).expanduser().absolute()
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


if __name__ == "__main__":
    main(sys.argv)
