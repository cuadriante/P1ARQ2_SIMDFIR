import os
import re # Importa el módulo de expresiones regulares

# Definición del conjunto de instrucciones con campo 'format' añadido
instruction_set = {
    'ADD': {'format': 'R', 'funct7': '0000000', 'rs2': '', 'rs1': '', 'funct3': '000', 'rd': '', 'opcode': '0110011'},
    'SUB': {'format': 'R', 'funct7': '0100000', 'rs2': '', 'rs1': '', 'funct3': '000', 'rd': '', 'opcode': '0110011'},
    'SLL': {'format': 'R', 'funct7': '0000000', 'rs2': '', 'rs1': '', 'funct3': '001', 'rd': '', 'opcode': '0110011'},
    'SLT': {'format': 'R', 'funct7': '0000000', 'rs2': '', 'rs1': '', 'funct3': '010', 'rd': '', 'opcode': '0110011'},
    'XOR': {'format': 'R', 'funct7': '0000000', 'rs2': '', 'rs1': '', 'funct3': '100', 'rd': '', 'opcode': '0110011'},
    'SRL': {'format': 'R', 'funct7': '0000000', 'rs2': '', 'rs1': '', 'funct3': '101', 'rd': '', 'opcode': '0110011'},
    'SRA': {'format': 'R', 'funct7': '0100000', 'rs2': '', 'rs1': '', 'funct3': '101', 'rd': '', 'opcode': '0110011'},
    'OR': {'format': 'R', 'funct7': '0000000', 'rs2': '', 'rs1': '', 'funct3': '110', 'rd': '', 'opcode': '0110011'},
    'AND': {'format': 'R', 'funct7': '0000000', 'rs2': '', 'rs1': '', 'funct3': '111', 'rd': '', 'opcode': '0110011'},
    'ADDI': {'format': 'I', 'inmediato': '', 'rs1': '', 'funct3': '000', 'rd': '', 'opcode': '0010011'},
    'SLTI': {'format': 'I', 'inmediato': '', 'rs1': '', 'funct3': '010', 'rd': '', 'opcode': '0010011'},
    'XORI': {'format': 'I', 'inmediato': '', 'rs1': '', 'funct3': '100', 'rd': '', 'opcode': '0010011'},
    'ORI': {'format': 'I', 'inmediato': '', 'rs1': '', 'funct3': '110', 'rd': '', 'opcode': '0010011'},
    'ANDI': {'format': 'I', 'inmediato': '', 'rs1': '', 'funct3': '111', 'rd': '', 'opcode': '0010011'},
    'SLLI': {'format': 'I', 'funct7': '0000000', 'inmediato': '', 'rs1': '', 'funct3': '001', 'rd': '', 'opcode': '0010011'},
    'SRLI': {'format': 'I', 'funct7': '0000000', 'inmediato': '', 'rs1': '', 'funct3': '101', 'rd': '', 'opcode': '0010011'},
    'SRAI': {'format': 'I', 'funct7': '0100000', 'inmediato': '', 'rs1': '', 'funct3': '101', 'rd': '', 'opcode': '0010011'},
    'LW': {'format': 'LW', 'inmediato': '', 'rs1': '', 'funct3': '010', 'rd': '', 'opcode': '0000011'},
    'SW': {'format': 'S', 'inmediato': '', 'rs2': '', 'rs1': '', 'funct3': '010', 'opcode': '0100011'},
    'BEQ': {'format': 'SB', 'inmediato': '', 'rs2': '', 'rs1': '', 'funct3': '000', 'opcode': '1100011'},
    'JAL': {'format': 'UJ', 'inmediato': '', 'rd': '', 'opcode': '1101111'},
    'ADDV': {'format': 'CUSTOM', 'funct7': '0000000', 'rs2': '', 'rs1': '', 'funct3': '000', 'rd': '', 'opcode': '1000000'},
    'MULV': {'format': 'CUSTOM', 'funct7': '0000000', 'rs2': '', 'rs1': '', 'funct3': '000', 'rd': '', 'opcode': '1000001'},
    'ROTV': {'format': 'CUSTOM', 'funct7': '0000000', 'rs2': '', 'rs1': '', 'funct3': '000', 'rd': '', 'opcode': '1000011'},
    'STV': {'format': 'CUSTOM', 'offset': '', 'rs2': '', 'rs1': '', 'funct3': '010', 'opcode': '1000100'},
    'LDV': {'format': 'CUSTOM', 'offset': '', 'rs1': '', 'funct3': '010', 'rd': '', 'opcode': '1000101'},
}

MEM_SIZE = 1024
STALL = [0] * 32
INSTRUCTION_LENGTH = 32

def read_instructions_from_file(file_path):
    global pc
    labels, instructions = [], []
    with open(file_path, 'r') as file:
        pc = 0
        for line in file:
            # Eliminar comentarios
            line = line.split(';')[0].strip().lower()
            if line.endswith(':'):
                labels.append({'name': line[:-1], 'pc': pc})
            elif line:
                instructions.append(line)
                pc += 4  # Suponiendo 4 bytes por instrucción
    return instructions, labels


def compile_instructions(instructions, labels):
    binary_instructions = []
    for instruction in instructions:
        binary_instruction = decode_instruction(instruction, labels)
        if binary_instruction:
            binary_instructions.append(binary_instruction)
    return binary_instructions

def decode_instruction(instruction, labels):
    print(instruction)
    parts = instruction.split()
    operation = parts[0].upper()
    operands = parts[1:]  # Esto debería ser una lista de operandos, como ['x1', 'x2', '#10']
    inst_format = instruction_set[operation]['format']
    if inst_format == 'R':
        return process_R_format(operation, operands)
    elif inst_format == 'I':
        return process_I_format(operation, operands, labels)
    elif inst_format == 'S':
        return process_S_format(operation, operands)
    elif inst_format == 'SB':
        return process_SB_format(operation, operands, labels)
    elif inst_format == 'UJ':
        return process_UJ_format(operation, operands, labels)
    elif inst_format == 'CUSTOM':
        return process_CUSTOM_format(operation, operands, labels)
    elif inst_format == 'LW':
        return process_LW_format(operation, operands, labels)
    else:
        print(f"Unsupported operation: {operation}")
        return None

def get_instruction_format(operation):
    return instruction_set.get(operation, {}).get('format', None)

def format_register(reg):
    """Formatea un registro a su representación binaria, asegurando que no haya caracteres adicionales."""
    reg = re.sub(r'[^0-9]', '', reg)  # Elimina cualquier carácter no numérico
    return '{:05b}'.format(int(reg))

def process_LW_format(operation, operands, labels):
    """
    Procesa instrucciones de formato LW para cargar un valor desde memoria.
    El primer operando es el registro destino y el segundo puede ser un registro
    o un inmediato, indicando la dirección de memoria de la cual cargar el valor.
    """
    if len(operands) != 2:
        raise ValueError(f"Número incorrecto de operandos para LW: {operands}")

    rd, second_operand = operands

    if second_operand.startswith('#'):
        # El segundo operando es un valor inmediato, manejar como dirección de memoria inmediata
        imm = format_immediate(second_operand, bits=12)
        rs1 = '00000'  # Utilizar un registro base ficticio, si tu arquitectura lo requiere
    elif second_operand.startswith('r'):
        # El segundo operando es un registro, usar su valor como dirección base
        rs1 = format_register(second_operand)
        imm = '000000000000'  # Offset cero si se carga directamente de un registro
    else:
        raise ValueError(f"Operando no válido en LW: {second_operand}")

    bits = instruction_set['LW']
    compiled_instruction = f"{imm}{format_register(rs1)}{bits['funct3']}{format_register(rd)}{bits['opcode']}"
    print(f"Compilando LW: {compiled_instruction}")
    return compiled_instruction


def format_immediate(imm, bits=12):
    """
    Formatea un valor inmediato a su representación binaria.
    Puede manejar valores decimales y hexadecimales.
    """
    # Elimina el prefijo '#'
    imm = imm.replace('#', '')
    
    # Detecta y convierte valores hexadecimales
    if imm.startswith('0x') or imm.startswith('-0x'):
        imm_value = int(imm, 16)  # Convierte de hexadecimal a decimal
    else:
        imm_value = int(imm)  # Convierte de decimal a decimal (básicamente, no cambia)
    
    # Manejo de valores negativos en complemento a dos
    if imm_value < 0:
        imm_value = (1 << bits) + imm_value
    
    return '{:0{bits}b}'.format(imm_value & ((1 << bits) - 1), bits=bits)

def process_R_format(operation, operands):
    """Procesa instrucciones de formato R."""
    rd, rs1, rs2 = operands
    bits = instruction_set[operation]
    compiled_instruction = f"{bits['funct7']}{format_register(rs2)}{format_register(rs1)}{bits['funct3']}{format_register(rd)}{bits['opcode']}"
    print(f"Compilando {operation}: {compiled_instruction}")
    return compiled_instruction

def process_I_format(operation, operands, labels=None):
    """
    Procesa instrucciones de formato I, adecuado tanto para operaciones aritméticas
    como para cargas de memoria, donde se espera un registro, un registro base y un valor inmediato.
    """
    bits = instruction_set[operation]
    opcode = bits['opcode']
    funct3 = bits['funct3']

    # Asegura que hay un número correcto de operandos
    if len(operands) != 3:
        raise ValueError(f"Número incorrecto de operandos para {operation}: {operands}")

    rd, rs1, imm_operand = operands

    # Usa format_immediate para manejar correctamente valores hexadecimales
    imm = format_immediate(imm_operand, 12)  # Maneja correctamente los valores inmediatos

    compiled_instruction = f"{imm}{format_register(rs1)}{funct3}{format_register(rd)}{opcode}"
    print(f"Compilando {operation}: {compiled_instruction}")
    return compiled_instruction


def process_S_format(operation, operands):
    """
    Procesa instrucciones de formato S, adecuado para almacenar valores en memoria.
    Espera dos registros, uno con el valor a almacenar y otro con la dirección base de memoria.
    """
    bits = instruction_set[operation]
    opcode = bits['opcode']

    # Asegura que hay un número correcto de operandos
    if len(operands) != 2:
        raise ValueError(f"Número incorrecto de operandos para {operation}: {operands}")

    rs1, rs2 = operands

    compiled_instruction = f"{format_immediate('0', 7)}{format_register(rs2)}{format_register(rs1)}{bits['funct3']}{format_immediate('0', 5)}{opcode}"
    print(f"Compilando {operation}: {compiled_instruction}")
    return compiled_instruction



def process_SB_format(operation, operands, labels):
    """Procesa instrucciones de formato SB para saltos condicionales."""
    rs1, rs2, label = operands
    bits = instruction_set[operation]
    # Aquí necesitarías calcular el offset basado en la etiqueta y la posición actual
    # Este es un placeholder para el cálculo del offset
    offset = '000000000000'  # Este valor debe calcularse correctamente
    compiled_instruction = f"{offset[0]}{offset[2:8]}{format_register(rs2)}{format_register(rs1)}{bits['funct3']}{offset[8:12]}{offset[1]}{bits['opcode']}"
    print(f"Compilando {operation}: {compiled_instruction}")
    return compiled_instruction

def process_UJ_format(operation, operands, labels):
    global pc
    bits = instruction_set[operation]
    opcode = bits['opcode']

    if len(operands) != 2:
        raise ValueError(f"Número incorrecto de operandos para {operation}: {operands}")

    rd, label_operand = operands

    # Busca la dirección de la etiqueta
    label_address = None
    for lbl in labels:
        if lbl['name'] == label_operand:
            label_address = lbl['pc']
            break

    if label_address is None:
        raise ValueError(f"Etiqueta no encontrada: {label_operand}")

    # Calcula el offset respecto al pc actual
    offset = label_address - pc

    # Prepara los bits del valor inmediato
    imm_20 = (offset >> 20) & 1
    imm_10_1 = (offset >> 1) & 0x3FF
    imm_11 = (offset >> 11) & 1
    imm_19_12 = (offset >> 12) & 0xFF

    # Combina los bits del valor inmediato
    imm = (imm_20 << 19) | (imm_19_12 << 11) | (imm_11 << 10) | imm_10_1

    # Asegura que el valor inmediato se ajuste a 20 bits
    if imm & (1 << 19):  # Si el bit 19 es 1, es negativo y extendemos el signo
        imm |= 0xFFF00000  # Extensión de signo para valores negativos en complemento a dos

    # Formatea el registro destino y concatena la instrucción
    rd_bits = format_register(rd)
    imm_bits = format(imm & 0xFFFFF, '020b')  # Asegura que imm es de 20 bits
    compiled_instruction = f"{imm_bits}{rd_bits}{opcode}"

    print(f"Compilando {operation}: {compiled_instruction}")
    return compiled_instruction

def process_CUSTOM_format(operation, operands, labels=None):
    bits = instruction_set[operation]
    opcode = bits['opcode']
    
    if operation in ['ADDV', 'MULV', 'ROTV']:
        # Procesamiento para operaciones vectoriales que usan rd, rs1, y rs2.
        rd, rs1, rs2 = operands
        compiled_instruction = f"{bits['funct7']}{format_register(rs2)}{format_register(rs1)}{bits['funct3']}{format_register(rd)}{opcode}"
    
    elif operation == 'LDV':
        # Ajusta para manejar 'LDV rd, #imm' o 'LDV rd, rs1'
        if len(operands) != 2:
            raise ValueError(f"Número incorrecto de operandos para {operation}: {operands}")
        
        rd, operand2 = operands
        if operand2.startswith('#'):  # Si el segundo operando es un valor inmediato
            # Procesa el valor inmediato correctamente
            imm = format_immediate(operand2, 12)
            rs1 = '00000'  # En el formato LDV, el rs1 se establece a '0' si es un inmediato
        else:  # Si el segundo operando es un registro
            rs1 = operand2
            imm = '0' * 12  # Suponiendo que el valor inmediato no se utiliza cuando es un registro
        compiled_instruction = f"{imm}{format_register(rs1)}{bits['funct3']}{format_register(rd)}{opcode}"
        
    elif operation == 'STV':
        bits = instruction_set[operation]
        opcode = bits['opcode']

        # Asegura que hay un número correcto de operandos
        if len(operands) != 2:
            raise ValueError(f"Número incorrecto de operandos para {operation}: {operands}")

        rs1, rs2 = operands

        compiled_instruction = f"{format_immediate('0', 7)}{format_register(rs2)}{format_register(rs1)}{bits['funct3']}{format_immediate('0', 5)}{opcode}"
        
    else:
        raise ValueError(f"Operación CUSTOM no soportada: {operation}")
    
    print(f"Compilando {operation}: {compiled_instruction}")
    return compiled_instruction




def write_output(compiled_instructions, output_path):
    if os.path.exists(output_path):
        os.remove(output_path)
    with open(output_path, 'w') as file:
        for instruction in compiled_instructions:
            file.write(f'{instruction}\n')
        fill_with_stall_bytes(file)

def fill_with_stall_bytes(file):
    file_size = file.tell()
    stall_bytes_needed = (MEM_SIZE - file_size) // INSTRUCTION_LENGTH
    for _ in range(stall_bytes_needed):
        file.write(''.join(str(x) for x in STALL) + '\n')

def compilar(input_file_name):
    base_name = os.path.basename(input_file_name)
    input_file = input_file_name
    
    # Construye el nombre del archivo de salida reemplazando la extensión
    output_file_name = os.path.splitext(base_name)[0] + '.bin'
    
    # Construye el camino completo del archivo de salida dentro de la carpeta "compilado"
    output_file_path = os.path.join('Lenguaje Alto Nivel', 'compilador', 'bin', output_file_name)
    
    
    # Asegura que el directorio de salida exista
    os.makedirs(os.path.dirname(output_file_path), exist_ok=True)
    
    # Aquí iría tu lógica de compilación, usando input_file y output_file_path
    instructions, labels = read_instructions_from_file(input_file)
    compiled_instructions = compile_instructions(instructions, labels)
    write_output(compiled_instructions, output_file_path)
    print(f"Archivo {input_file_name} compilado a {output_file_path}")
