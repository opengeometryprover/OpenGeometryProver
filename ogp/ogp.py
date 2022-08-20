#!/usr/bin/env python3


import argparse
import sys

import const


parser = argparse.ArgumentParser(description = "Open Geometry Prover")
parser.add_argument("-l", "--list",
                    help = "lists provers known to OGP and exit",
                    action = "store_true")
parser.add_argument("-t", "--timeout", type = int, default = const.TIMEOUT,
                    help = "timeout (s) to test a prover with a conjecture")
parser.add_argument("-p", "--prover", help ="prover to be used known to OGP")
parser.add_argument("-o", "--options",  default = None,
                    help = "options to be passed to the prover")
parser.add_argument("-V", "--version", help = "shows OGP version and exit",
                    action = "store_true")
parser.add_argument("conjecture", nargs = "?", default = None,
                 help = "the conjecture to test")

# args = parser.parse_args()

if len(sys.argv) == 1:
    parser.print_help()
else:
    args = parser.parse_args()
