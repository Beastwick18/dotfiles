from inspect import signature

cmds = {}
default_cmd = None

class Entry:
    def __init__(self, name, desc, func) -> None:
        self.name = name
        self.desc = desc
        self.func = func

def help(app_name):
    print(f"Usage: {app_name} <action>\nActions:")
    for name, e in cmds.items():
        sig = signature(e.func)
        fargs = sig.parameters.keys()
        full = " ".join([name] + [f'<{k}>' for k in fargs])
        print(f"  {full:15} {e.desc}")

def cmd(name, desc=""):
    def create_entry(func):
        global cmds, default_cmd
        cmds[name] = Entry(name, desc, func)
    return create_entry

def run(app_name, args):
    if len(args) < 2:
        help(app_name)
        return
    for name, e in cmds.items():
        if args[1] == name:
            sig = signature(e.func)
            fargs = sig.parameters.keys()
            if len(fargs) != len(args) - 2:
                print(f"Expected: {app_name} " + " ".join([name] + [f'<{k}>' for k in fargs]))
                exit(1)
            e.func(*args[2:])
            return
    help(app_name)
