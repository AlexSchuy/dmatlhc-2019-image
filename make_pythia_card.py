#!/usr/bin/env python
import argparse
import subprocess


def make_card(inputlhe, nevents):
    runcardtmpl = 'pythia.tmpl'
    runcardname = 'pythia_card.dat'
    with open(runcardtmpl, 'r') as template:
        with open(runcardname, 'w+') as filled:
            filled.write(template.read().format(
                LHEF=inputlhe, NEVENTS=nevents))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Steer pythia8.')
    parser.add_argument('inputlhe', help='Path to input LHE file.')
    parser.add_argument('nevents', help='number of events.')
    args = parser.parse_args()
    make_card(args.inputlhe, args.nevents)
