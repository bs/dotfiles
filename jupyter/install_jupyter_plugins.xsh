import re

def parse_plugins(plugin_str):
    plugins = []
    print('hi!')

    # jupyter labextension list for some odd reason returns the list as stderr
    for line in plugin_str.split('\n'):
        if re.compile('.*enabled  OK$').match(line):

            # and with a lot of whitespace we need to strip out
            plugins.append(re.compile(r'^(.*?)\s').findall(line.strip())[0])

    return plugins

def get_plugins():
    """from the xonsh you can throw this directly into parse_plugins() or pipe it to the shell with
    >>> get_plugins() all> plugins.txt or the equiv"""

    !(jupyter labextension list).err


def install_plugins(plugins):
    for x in plugins:
        ![jupyter labextension install @(x)]
