#!/usr/bin/env python3

import collections
import re
import sys

from elftools.elf import elffile
from elftools.common.exceptions import ELFError
from elftools.common.py3compat import bytes2str
from elftools.dwarf.descriptions import describe_form_class

from dwarfalu import get_location, get_string

Func = collections.namedtuple("Func", "low_pc, high_pc, unit, entry")


def main():
    prog = sys.argv[1] if sys.argv[1:] else "a.out"
    try:
        elf = elffile.ELFFile(open(prog, "rb"))
    except (IOError, ELFError) as ex:
        print("Opening", prog, "→", ex, file=sys.stderr)
        return 1
    else:
        if not elf.has_dwarf_info():
            print("{}: no DWARF info?".format(prog))
            return 1

    process_backtrace(sys.stdin, elf)


def process_backtrace(lines, elf):
    """Prints human-readable details from backtrace() output.
    """
    rgx = re.compile(r"^#\d+\s")
    dwarf = elf.get_dwarf_info()
    funcs = get_functions(dwarf)

    for line in lines:
        if not rgx.search(line):
            continue

        num, fp, addr, _, *args, _ = line.split()
        addr = int(addr, 0)
        args = [int(x, 0) for x in args]

        for f in funcs:
            if not f.low_pc <= addr <= f.high_pc:
                continue

            # Found the function.
            name = bytes2str(f.entry.attributes['DW_AT_name'].value)
            args = annotate_args(args, f.entry)
            line = "{} {} 0x{:x} in {} ({})".format(num, fp, addr, name, args)
            location = get_location(addr, dwarf.line_program_for_CU(f.unit))
            if location:
                line += " at {}:{}".format(location[0], location[1])
            print(line)
            break


def annotate_args(args, func_entry):
    """Anotates a list of argument values with their names.
    """
    idx = 0
    fmt = []
    for entry in func_entry.iter_children():
        if entry.tag == "DW_TAG_formal_parameter":
            name = bytes2str(entry.attributes["DW_AT_name"].value)
            value = args[idx]
            if name == "msg":
                # Hard-coded special case: get value as string from ELF.
                value = '0x{:x} "{}"'.format(value, get_string(value, 0))
            fmt.append("{}={}".format(name, value))
            idx += 1

    return ", ".join(fmt)


def get_functions(dwarfinfo):
    """Returns a list of ELF functions as Func tuples, sorted by address.
    """
    funcs = []

    for unit in dwarfinfo.iter_CUs():
        for entry in unit.iter_DIEs():
            if entry.tag in ("DW_TAG_subprogram", "DW_TAG_inlined_subroutine"):
                try:
                    low = entry.attributes["DW_AT_low_pc"].value
                    high = entry.attributes["DW_AT_high_pc"]
                    addr_type = describe_form_class(high.form)
                except KeyError:
                    continue
                else:
                    if addr_type == "address":
                        high = high.value
                    elif addr_type == "constant":
                        high = low + high.value
                    else:
                        print("Invalid DW_AT_high_pc?",
                              addr_type, file=sys.stderr)
                        continue

                    funcs.append(Func(low, high, unit, entry))

    return sorted(funcs)


if __name__ == "__main__":
    sys.exit(main())
