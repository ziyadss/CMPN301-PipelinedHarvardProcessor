import re

ops = {}
txt = open("operations.txt", 'r')
for line in txt:
    if line == '\n':
        continue
    key, val = line.split()
    ops[key.upper()] = val

strings = open("instructions.txt", 'r').read().splitlines()
insts = map(lambda x: re.sub(r'[(),]', ' ', x).split(), strings)

binary = []

for inst in insts:
    part = []
    if len(inst) > 0:
        part.append(ops[inst[0].upper()])
    if len(inst) > 1:
        part.append(f'{int(inst[1][1]):03b}')
    if len(inst) > 2:
        part.append(None)
        if part[0][0:4] == "1110":
            inst[2], inst[3] = inst[3], inst[2]
            part.append(f'{int(inst[3]):021b}')
        if part[0][0:4] == "0110":
            part[2] = f'{int(inst[2]):08b}'
        elif part[0][0:4] == "1111":
            part[2] = f'{int(inst[2]):024b}'
        else:
            part[2] = f'{int(inst[2][1]):03b}'

    binary.append(part)


def prepInst(part):
    x = "".join(part)
    z = x, x
    if part:
        z = x.ljust(16, '0'), hex(int(x, 2))[2:].upper().ljust(4, '0')
    return z


binNhex = map(prepInst, binary)

txt1 = open("binary.txt", 'w')
txt2 = open("hexa.txt", 'w')
for line in binNhex:
    txt1.write(f"{line[0]}\n")
    txt2.write(f"{line[1]}\n")
