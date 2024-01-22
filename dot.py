#!/bin/python3

import json
import os
import sys
import subprocess
import time
from pathlib import Path
import dotlib

MAP_FILE = "dotfiles.json"

@dotlib.cmd("help", default=True)
def print_help(args):
    print("Usage: dot <action>")
    print("Actions:")
    print("  list (default): List all mapped dotfiles")
    print("  install: Install dotfiles by creating symlinks")
    print("  sync: Sync dotfiles with remote")
    print("  pull: Pull any changes from remote")
    print("  push: Push any local changes to remote")
    print("  add: Add a local file/dir to the dotfile repo")
    print("  diff: Show unsynced changes")

@dotlib.cmd("install")
def install(args):
    os.chdir(exe)
    for k in cfg:
        create_link(k)
    os.chdir(cwd)
    return 0

@dotlib.cmd("sync")
def sync(args):
    os.chdir(exe)
    date = time.strftime("%m-%d-%y %H:%M:%S")
    print(date)
    subprocess.run(["git", "pull"])
    subprocess.run(["git", "add", "--all"])
    subprocess.run(["git", "commit", "-m", date])
    subprocess.run(["git", "push"])
    os.chdir(cwd)
    return 0

@dotlib.cmd("pull")
def pull(args):
    os.chdir(exe)
    subprocess.run(["git", "pull"])
    os.chdir(cwd)

@dotlib.cmd("pull")
def push(args):
    os.chdir(exe)
    date = time.strftime("%m-%d-%y %H:%M:%S")
    print(date)
    subprocess.run(["git", "add", "--all"])
    subprocess.run(["git", "commit", "-m", date])
    subprocess.run(["git", "push"])
    os.chdir(cwd)

@dotlib.cmd("add")
def add(args):
    if len(args) < 2:
        print("Usage: dot add <path>")
        return 1
    home = Path.home().absolute()
    orig = Path(args[1]).expanduser().absolute()

    # Replace /home/$USER with ~
    link_to = str(orig)
    if link_to.startswith(str(home)):
        link_to = link_to.replace(str(home), "~", 1)

    if not orig.exists():
        print(f"{orig}: Does not exist")
        return 1
    if orig.is_symlink():
        print(f"{orig}: A symlink already exists at this location")
        return 1

    dotfile = exe.joinpath(orig.name)
    is_dir = orig.is_dir()
    if dotfile.exists():
        print(f"{dotfile}: Already exists")
        return 1
    print(f"mv {orig} -> {dotfile}")
    orig.rename(dotfile)
    orig.symlink_to(dotfile, target_is_directory=is_dir)
    cfg[dotfile.name] = link_to
    print(f"map {dotfile.name} -> {link_to}")
    os.chdir(exe)
    write_map(MAP_FILE)
    os.chdir(cwd)
    return 0

@dotlib.cmd("diff")
def diff(args):
    os.chdir(exe)
    subprocess.run(["git", "diff"])
    os.chdir(cwd)


@dotlib.cmd("list")
def list_map(args):
    print(f"{MAP_FILE}:")
    for k, v in cfg.items():
        print(f"  {k} -> {v}")
    return 0

def main(args):
    global cfg, exe, cwd
    cwd = Path.cwd().expanduser().absolute()
    exe = Path(args[0]).expanduser().absolute()
    if exe.is_symlink():
        exe = exe.readlink().parent.absolute()
    else:
        exe = exe.parent.absolute()

    os.chdir(exe)
    cfg = load_map(MAP_FILE)
    os.chdir(cwd)

    # sub_arg = args[1:]
    dotlib.run(args)

    # if len(arg) < 2 or arg[1] == "list":
    #     exit(list_map())
    # elif arg[1] == "install":
    #     exit(install())
    # elif arg[1] == "add":
    #     exit(add(sub_arg))
    # elif arg[1] == "sync":
    #     exit(sync())
    # elif arg[1] == "pull":
    #     exit(pull())
    # elif arg[1] == "push":
    #     exit(push())
    # elif arg[1] == "diff":
    #     exit(diff())
    # else:
    #     print_help()

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

def write_map(filename):
    with open(filename, "w") as file:
        json.dump(cfg, file, ensure_ascii=False, indent=2)


if __name__ == "__main__":
    main(sys.argv)
