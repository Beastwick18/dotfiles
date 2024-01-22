cmds = {}
default_cmd = None

def cmd(name, default=False):
    def create_entry(f):
        global cmds, default_cmd
        if default:
            default_cmd = f
        cmds[name] = f
    return create_entry

def run(args):
    for name, func in cmds.items():
        if args[1] == name:
            func(args)
            return
    if default_cmd:
        default_cmd(args)
