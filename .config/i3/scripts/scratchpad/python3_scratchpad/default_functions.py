#!/usr/bin/env python3
import os
import sys


def clear():
    os.system("clear")


def exit():
    print("\n")
    sys.exit()


def get_python_version():
    return ".".join([str(x) for x in sys.version_info[:3]])
