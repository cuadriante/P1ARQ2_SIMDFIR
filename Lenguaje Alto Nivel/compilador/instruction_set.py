# Definiciones de constantes del conjunto de instrucciones
INSTRUCTION_LENGTH = 32  # Longitud en bits de una instrucción
OP_CODES = {
    'R_TYPE': '0000000',
    'I_TYPE': '0000001',
    'B_TYPE': '0000010',
    'J_TYPE': '0000011',
    # Agrega más códigos de operación según sea necesario
}
FUNC_CODES = {
    'add': {'funct7': '0000000', 'funct3': '000'},
    'sub': {'funct7': '0100000', 'funct3': '000'},
    'mul': {'funct7': '0000001', 'funct3': '000'},
    'addv': {'funct7': '0000010', 'funct3': '000'},  # Ejemplo de código de función para instrucción vectorial
    # Agrega más códigos de función según sea necesario
}
REGISTERS = {
    'r0': '00000',
    'r1': '00001',
    'r2': '00010',
    # Mapea nombres de registros a números de registro según sea necesario
}
MEM_SIZE = 1024  # Tamaño de la memoria
STALL = ['0' * INSTRUCTION_LENGTH] * 32  # Valor de parada de ejemplo

# Definiciones específicas para las operaciones vectoriales
VECTOR_LENGTH = 128  # Longitud en bits de un vector
# Agrega más constantes específicas para operaciones vectoriales según sea necesario

# Definiciones del conjunto de instrucciones
instruction_set = {
    # Operaciones ALU
    'add': {'op_code': OP_CODES['R_TYPE'], 'mnemonic': 'add', 'type': 'alu'},
    'sub': {'op_code': OP_CODES['R_TYPE'], 'mnemonic': 'sub', 'type': 'alu'},
    'mul': {'op_code': OP_CODES['R_TYPE'], 'mnemonic': 'mul', 'type': 'alu'},
    # Operaciones de salto
    'beq': {'op_code': OP_CODES['B_TYPE'], 'mnemonic': 'beq', 'type': 'branch'},
    'bne': {'op_code': OP_CODES['B_TYPE'], 'mnemonic': 'bne', 'type': 'branch'},
    # Operaciones de carga/guardado
    'lw': {'op_code': OP_CODES['I_TYPE'], 'mnemonic': 'lw', 'type': 'load_store'},
    'ldv': {'op_code': OP_CODES['I_TYPE'], 'mnemonic': 'ldv', 'type': 'load_store'},
    'stv': {'op_code': OP_CODES['I_TYPE'], 'mnemonic': 'stv', 'type': 'load_store'},
    'lde': {'op_code': OP_CODES['I_TYPE'], 'mnemonic': 'lde', 'type': 'load_store'},
    'ste': {'op_code': OP_CODES['I_TYPE'], 'mnemonic': 'ste', 'type': 'load_store'},
    # Operaciones vectoriales
    'rotv': {'op_code': OP_CODES['I_TYPE'], 'mnemonic': 'rotv', 'type': 'vector'},
    'addv': {'op_code': OP_CODES['R_TYPE'], 'mnemonic': 'addv', 'type': 'vector'},
    'mulv': {'op_code': OP_CODES['R_TYPE'], 'mnemonic': 'mulv', 'type': 'vector'},
    # Operaciones de flujo de control
    'jal': {'op_code': OP_CODES['J_TYPE'], 'mnemonic': 'jal', 'type': 'control_flow'},
    'jmp': {'op_code': OP_CODES['J_TYPE'], 'mnemonic': 'jmp', 'type': 'control_flow'},
    # Operación de comparación
    'cmp': {'op_code': OP_CODES['R_TYPE'], 'mnemonic': 'cmp', 'type': 'comparison'},
}

def immediate_val(value):
    # Convertir un valor inmediato a su representación binaria de 32 bits
    return bin(int(value))[2:].zfill(32)
