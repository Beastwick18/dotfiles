from inspect import Parameter, signature
import inspect
import json
from types import UnionType
from typing import Any, Callable, Union, Optional
import typing
from pathlib import Path


def __is_union(param: Parameter):
    t = typing.get_origin(param.annotation)
    return t is Union or t is UnionType

def __is_optional(param: Parameter):
    field = param.annotation
    return __is_union(param) and \
           type(None) in typing.get_args(field)

def is_required(param: Parameter):
    return param.default is inspect._empty and not __is_optional(param)

class __Entry:
    def __init__(self, name: str, desc: str, func: Callable):
        self.name = name
        sig = signature(func)
        self.fullname = f"{name}"
        for p in sig.parameters:
            param = sig.parameters[p]
            if is_required(param):
                self.fullname += f" <{param.name}>"
            else:
                self.fullname += f" [{param.name}]"
        self.desc = desc
        self.func = func

__cmds = dict[str,__Entry]()
__default_cmd: Optional[Callable] = None

def __help(app_name: str, help_cmd: str):
    print(f"Usage: {app_name} <action>\nActions:")
    l = 0
    for v in __cmds.values():
        l = max(len(v.fullname), l)
    print(f"  {help_cmd:{l+2}} Show this message")
    for e in __cmds.values():
        print(f"  {e.fullname:{l+2}} {e.desc}")

def cmd(name: str | None = None, desc: str = "", default_cmd: bool = False):
    def create_entry(func: Callable):
        global __cmds, __default_cmd
        nonlocal name
        if name is None:
            name = str(func.__name__)
        __cmds[name] = __Entry(name, desc, func)
        if default_cmd:
            sig = signature(func)
            required = sum(1 for p in sig.parameters if is_required(sig.parameters[p]))
            if required != 0:
                raise Exception(f"Number of required arguments must be 0, but was {required}")
            __default_cmd = func
    return create_entry

def load_map(filename: str | Path) -> dict[str,str]:
    with open(filename) as file:
        return json.load(file)

def write_map(cfg: dict[str,str], filename: str | Path):
    with open(filename, "w") as file:
        json.dump(cfg, file, ensure_ascii=False, indent=2)

def create_link(cfg: dict[str,str], name: str, cwd: Path = Path()):
    if name not in cfg:
        print(f'Error: Unknown name "{name}"')
        return

    src = cwd.joinpath(Path(name).expanduser().absolute())
    if not src.exists():
        print(f'Error: "{name}" does not exist ')
        return

    dst = Path(cfg[name]).expanduser().absolute()
    if dst.is_symlink():
        if dst.readlink().exists():
            if dst.readlink().expanduser().absolute() == src:
                print(f'Error: "{name}" already linked')
                return
            if ask(f"{name}: Another link already exists, would you like to overwrite it?"):
                return
        # Otherwise, this link must be broken. Delete it
        dst.unlink()


    if not ask(f"Link {name} -> {cfg[name]}"):
        return

    if dst.exists():
        try:
            new_path = dst.replace(dst.with_name(dst.name + ".bak"))
        except:
            print(f'Error: Path "{name}" exists, but unable to create backup')
            return
        print(f"Created backup for {name} located at {new_path}")

    try:
        dst.symlink_to(src, target_is_directory=src.is_dir())
    except:
        print(f'Error: Unable to create symlink "{src}" for "{name}"')

def ask(q: str, default_yes: bool = False):
    yes_no = "Y/n" if default_yes else "y/N"
    result = input(f"{q} [{yes_no}] ").lower().strip()
    return not result == "n" and (result == "y" or default_yes)

def __union_cast(union: UnionType, val: Any):
    args = typing.get_args(union)
    val_type = type(val)
    # First check if type of val is already present in union
    for a in args:
        if val_type == a:
            return val

    # Otherwise, try and accept whichever cast succeeds first
    for a in args:
        try:
            ret = a(val)
            return ret
        except:
            pass
    raise Exception(f'Could not cast "{val}" to type in Union[{args}]')

def __get_kwargs(func: Callable, args: list[str]):
    sig = signature(func)
    required = 0
    max = len(sig.parameters.keys())
    required = sum(1 for p in sig.parameters if is_required(sig.parameters[p]))
    given = len(args)
    args_given = args + [None] * (len(sig.parameters.keys()) - given)
    kwargs = dict[str, Any]()
    for p, g in zip(sig.parameters, args_given):
        param = sig.parameters[p]
        if g is None and not __is_optional(param):
            continue
        try:
            if __is_union(param):
                kwargs[p] = __union_cast(param.annotation, g)
            else:
                kwargs[p] = param.annotation(g)
        except Exception as err:
            print(err)
            print(f'Error: Expected argument supplied for "{param.name}" (given "{g}") to be of type "{param.annotation.__name__}"')
            exit(1)
    return kwargs, required, max

def run(app_name: str, args: list[str], help_cmd: str = "--help"):
    if len(args) < 2:
        if __default_cmd is None:
            __help(app_name, help_cmd)
        else:
            __default_cmd()
        return
    if args[1] == help_cmd:
        __help(app_name, help_cmd)
        return
    if args[1] in __cmds:
        e = __cmds[args[1]]
        given = args[2:]
        kwargs, required, max = __get_kwargs(e.func, given)
        if len(given) < required or len(given) > max:
            print(f"Error: Expected: {app_name} {e.fullname}")
            exit(1)

        exit(e.func(**kwargs))
    print(f"Error: Unknown command: {args[1]}")
    __help(app_name, help_cmd)
