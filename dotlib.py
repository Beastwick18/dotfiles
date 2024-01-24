from inspect import Parameter, signature
import inspect
import json
from typing import Callable, Union
import typing
from pathlib import Path

def is_optional_explicit(param: Parameter):
    field = param.annotation
    return typing.get_origin(field) is Union and \
           type(None) in typing.get_args(field)

def is_required(param: Parameter):
    return param.default is inspect._empty and not is_optional_explicit(param)

class Entry:
    def __init__(self, name: str, desc: str, func: Callable):
        self.name = name
        sig = signature(func)
        # fargs = sig.parameters.keys()
        self.fullname = f"{name}"
        for p in sig.parameters:
            param = sig.parameters[p]
            if is_required(param):
                self.fullname += f" <{param.name}>"
            else:
                self.fullname += f" [{param.name}]"
        # self.fullname = " ".join([name] + [f'<{k}>' for k in fargs])
        self.desc = desc
        self.func = func

cmds = dict[str,Entry]()

def help(app_name: str):
    print(f"Usage: {app_name} <action>\nActions:")
    l = 0
    for v in cmds.values():
        l = max(len(v.fullname), l)
    for e in cmds.values():
        print(f"  {e.fullname:{l+2}} {e.desc}")

def cmd(name: str | None = None, desc: str = ""):
    def create_entry(func: Callable):
        global cmds
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
    yes_no = "Y/n" if default_yes else "y/N"
    result = input(f"{q} [{yes_no}] ").lower().strip()
    if result == "n":
        return False
    return result == "y" or default_yes


def get_kwargs(func, args):
    sig = signature(func)
    required = 0
    max = len(sig.parameters.keys())
    required = sum(1 for p in sig.parameters if is_required(sig.parameters[p]))
    given = len(args)
    args_given = args + [None] * (len(sig.parameters.keys()) - given)
    kwargs = dict()
    for p, g in zip(sig.parameters, args_given):
        if g is None and not is_optional_explicit(sig.parameters[p]):
            continue
        kwargs[p] = g
    return kwargs, required, max

def run(app_name: str, args: list[str]):
    if len(args) < 2:
        help(app_name)
        return
    if args[1] in cmds:
        e = cmds[args[1]]
        kwargs, required, max = get_kwargs(e.func, args[2:])
        given = len(args[2:])
        if given < required or given > max:
            print(f"Expected: {app_name} " + e.fullname)
            exit(1)

        exit(e.func(**kwargs))
    print(f"Unknown command: {args[1]}")
    help(app_name)
