#!/bin/python3

import os
import sys
import subprocess
import time
from pathlib import Path
from typing import Optional
import dotlib

MAP_FILE = "dotfiles.json"
APP_NAME = "dot"

@dotlib.cmd(desc="Install dotfiles by creating symlinks")
def install():
    os.chdir(exe)
    for k in cfg:
        dotlib.create_link(cfg, k)
    os.chdir(cwd)

@dotlib.cmd(desc="Sync dotfiles with remote")
def sync():
    date = time.strftime("%m-%d-%y %H:%M:%S")
    print(date)
    subprocess.run(["git", "pull"], cwd=exe)
    subprocess.run(["git", "add", "--all"], cwd=exe)
    subprocess.run(["git", "commit", "-m", date], cwd=exe)
    subprocess.run(["git", "push"], cwd=exe)

@dotlib.cmd(desc="Pull any changes from remote")
def pull():
    subprocess.run(["git", "pull"], cwd=exe)

@dotlib.cmd(desc="Push any local changes to remote")
def push():
    date = time.strftime("%m-%d-%y %H:%M:%S")
    print(date)
    subprocess.run(["git", "add", "--all"], cwd=exe)
    subprocess.run(["git", "commit", "-m", date], cwd=exe)
    subprocess.run(["git", "push"], cwd=exe)

@dotlib.cmd(desc="Add a local file/dir to the dotfile repo")
def add(path: str, map_to: Optional[str]):
    home = Path.home().absolute()
    orig = Path(path).expanduser().absolute()
    if not map_to:
        dotfile = exe.joinpath(orig.name)
    else:
        dotfile = exe.joinpath(map_to)
    print(f"Map {orig} to {dotfile}")

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
    dotlib.write_map(cfg, exe.joinpath(MAP_FILE))

@dotlib.cmd(desc="Unadd a dotfile by returning the file to its original location outside of the repo")
def unadd(name: str):
    if name not in cfg:
        print(f'"{name}" does not exist in repo')
        return 1
    local = Path(cfg[name]).expanduser().absolute()
    repo = exe.joinpath(name).expanduser().absolute()
    if not local.exists() or not local.is_symlink():
        print(f'No symlink exists at "{local}"')
        return 1
    if not repo.exists():
        print(f'File does not exist in repo: "{repo}"')
        return 1
    if local.readlink() != repo:
        print(f'The repo file ({repo}) does not link to the local file ({local})')
        return 1

    if not dotlib.ask(f'Unadd "{name}" ({local})?'):
        return 0

    local.unlink()
    repo.rename(local)
    del cfg[name]

    dotlib.write_map(cfg, exe.joinpath(MAP_FILE))

@dotlib.cmd(desc="Show unsynced changes")
def diff():
    subprocess.run(["git", "diff"], cwd=exe)


@dotlib.cmd(name="list", desc="List all mapped dotfiles")
def list_map():
    print(f"{MAP_FILE}:")
    l = 0
    for k in cfg.keys():
        l = max(l, len(k))

    for k, v in cfg.items():
        print(f"  {k:>{l}} -> {v}")

def main(args):
    global cfg, exe, cwd
    cwd = Path.cwd().expanduser().absolute()
    exe = Path(args[0]).expanduser().absolute()
    if exe.is_symlink():
        exe = exe.readlink()
    exe = exe.parent.absolute()

    cfg = dotlib.load_map(exe.joinpath(MAP_FILE))

    dotlib.run(APP_NAME, args, help_cmd="help")

if __name__ == "__main__":
    main(sys.argv)
