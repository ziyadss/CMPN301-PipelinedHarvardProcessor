import re

fileNames = ["OneOperand", "TwoOperand", "Memory", "Branch"]
ops = {'NOP': '00000', 'SETC': '00010', 'CLRC': '00011', 'RET': '00100', 'MOV': '01110', 'ADD': '01000', 'SUB': '01001', 'AND': '01010', 'OR': '01011', 'CALL': '10000', 'NOT': '10001', 'INC': '10010', 'DEC': '10011',
       'OUT': '10100', 'IN': '10101', 'PUSH': '10110', 'POP': '10111', 'JZ': '11000', 'JN': '11001', 'JC': '11010', 'JMP': '11011', 'IADD': '11110', 'LDM': '11111', 'LDD': '11100', 'STD': '11101', 'SHL': '01100', 'SHR': '01101'}

def instruction(inst):
    part = []
    part.append(ops[inst[0].upper()])
    if len(inst) > 1:
        if inst[0].upper()=="IN":
            print('here')
        part.append(f'{(int(inst[1][1],16)-1):03b}')
    if len(inst) > 2:
        part.append(None)
        if part[0][0:4] == "1110":
            inst[2], inst[3] = inst[3], inst[2]
            part.append(f'{int(inst[3],16):021b}')
        if part[0][0:4] == "0110":
            part[2] = f'{int(inst[2],16):08b}'
        elif part[0][0:4] == "1111":
            part[2] = f'{int(inst[2],16):024b}'
        else:
            part[2] = f'{(int(inst[2][1],16)-1):03b}'
    return part


def fillMemory(memory):
    for i in range(max(memory.keys())):
        if i not in memory:
            memory[i] = f'{0:016b}'


def outputMemory(memory):
    with open(f"{fileName}.mem", 'w') as f:
        f.write(r'''// memory data file (do not edit the following line - required for mem load use)
// instance=/pipelinedprocessor/Fetch/RAM1/ram
// format=mti addressradix=h dataradix=s version=1.0 wordsperline=4''')
        for k in sorted(memory):
            if k % 4 == 0:
                f.write(f'\n{k:x}: ')
            f.write(f'{memory[k]} ')

def asm2mem(fileName):
    strings = open(f"{fileName}.asm", 'r').read().splitlines()
    insts = map(lambda x: re.sub(r'[(),]|#.*', ' ', x).split(), strings)
    
    memory = {}
    address = 0
    
    for inst in insts:
        if len(inst) == 0:
            continue
        if inst[0] == ".ORG":
            address = int(inst[1],16)
        elif inst[0].isnumeric():
            memory[address] = f'{int(inst[0],16):016b}'
            address = address+1
        else:
            binInst = "".join(instruction(inst)).ljust(16, '0')
            if len(binInst) == 16:
                memory[address] = binInst
                address = address+1
            else:
                memory[address] = binInst[0:15]
                memory[address+1] = binInst[16:31]
                address = address+2
    
    fillMemory(memory)
    outputMemory(memory)

for fileName in fileNames:
    asm2mem(fileName)