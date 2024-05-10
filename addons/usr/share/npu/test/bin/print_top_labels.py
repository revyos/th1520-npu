#!/usr/bin/python3.7
"""Prints the top N labels given a label file and network output (float32 array)
"""

import argparse
import os
import sys
import numpy as np

def parse_args():
    """Parse input arguments."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('-l', '--labels', dest='labels_path', required=True,
                        help='Path to the labels file')
    parser.add_argument('-n', '--net-out', dest='net_out', required=True,
                        help='Path to the network output file (raw float32 array)')
    parser.add_argument('-N', '--n-top', dest='n_top', type=int, default=5,
                        help='N top labels to be printed. Defaults to 5')
    parser.add_argument('-d', '--delimiter', default='\t',
                        help='The delimiter for the labels columns. Defaults to "\\t"')
    args = parser.parse_args()
    if (not os.path.exists(args.labels_path) or not os.path.isfile(args.labels_path)):
        print("Invalid labels file: {}".format(args.labels_path))
        sys.exit(1)
    if (not os.path.exists(args.net_out) or not os.path.isfile(args.net_out)):
        print("Invalid network output file: {}".format(args.net_out))
        sys.exit(1)

    return args


if __name__ == '__main__':

    args = parse_args()

    labels = np.loadtxt(args.labels_path, str, delimiter=args.delimiter)
    name,ext = os.path.splitext(args.net_out)
    if (ext == '.out'):
        net_out = np.fromfile(args.net_out, dtype='float32')
    elif (ext == '.txt'):
        net_out = np.loadtxt(args.net_out, dtype='float32')
        net_out = np.insert(net_out, 0, 0.0) # // insert backgroup as the first item in labels
    else:
        print("unsupport file format of net_out")
        sys.exit(0)
    top_inds = net_out.argsort()[::-1][:args.n_top]
    print("Top {} class(es):".format(len(top_inds)))
    for each in zip(top_inds, net_out[top_inds], labels[top_inds]):
        print("{}".format(str(each)), end='')

    print("", end='\n')

