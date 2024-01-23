from inspect import signature
import json
from typing import Callable
from pathlib import Path

cmds = {}
default_cmd = None

class Entry:
    def __init__(self, name: str, desc: str, func: Callable):
        self.name = name
        sig = signature(func)
        fargs = sig.parameters.keys()
        self.fullname = " ".join([name] + [f'<{k}>' for k in fargs])
        self.desc = desc
        self.func = func

def help(app_name: str):
    print(f"Usage: {app_name} <action>\nActions:")
    l = 0
    for v in cmds.values():
        l = max(len(v.fullname), l)
    for e in cmds.values():
        print(f"  {e.fullname:{l+2}} {e.desc}")

def cmd(name: str | None = None, desc: str = ""):
    def create_entry(func: Callable):
        global cmds, default_cmd
        nonlocal name
        if name is None:
            name = str(func.__name__)
        cmds[name] = Entry(name, desc, func)
    return create_entry

def load_map(filename: str | Path) -> dict[str,str]:
    with open(filename) as file:
        return json.load(file)

def write_map(cfg: dict[str,str], filename: str):
    with open(filename, "w") as file:
        json.dump(cfg, file, ensure_ascii=False, indent=2)

def create_link(cfg: dict[str,str], name: str):
    if name not in cfg:
        print(f"{name}: Unknown name")
        return

    src = Path(name).expanduser().absolute()
    if not src.exists():
        print(f"{name}: Does not exist")
        return

    dst = Path(cfg[name]).expanduser().absolute()
    if dst.is_symlink():
        if dst.readlink().exists():
            if dst.readlink().expanduser().absolute() == src:
                print(f"{name}: Already linked")
                return
            if ask(f"{name}: Another link already exists, would you like to overwrite it?"):
                return
        # Otherwise, this link must be broken. Delete it
        dst.unlink()


    if ask(f"Link {name} -> {cfg[name]}"):
        return

    if dst.exists():
        try:
            new_path = dst.replace(dst.with_name(dst.name + ".bak"))
        except:
            print(f"{name}: Path exists, but unable to create backup")
            return
        print(f"Created backup for {name} located at {new_path}")

    try:
        dst.symlink_to(src, target_is_directory=src.is_dir())
    except:
        print(f"{name}: Unable to create symlink")

def ask(q: str, default_yes=False):
    yes_no = "y/N"
    if default_yes:
        yes_no = "Y/n"
    result = input(f"{q} [{yes_no}] ").lower().strip()
    if result == "y":
        return True
    if result == "n":
        return False
    return default_yes

def run(app_name: str, args: list[str]):
    if len(args) < 2:
        help(app_name)
        return
    if args[1] in cmds:
        e = cmds[args[1]]
        sig = signature(e.func)
        fargs = sig.parameters.keys()
        if len(fargs) != len(args) - 2:
            print(f"Expected: {app_name} " + e.fullname)
            exit(1)
        exit(e.func(*args[2:]))
    help(app_name)
