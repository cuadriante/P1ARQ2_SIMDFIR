import compiler_core as cc
import glob
import os

base_path = r'Lenguaje Alto Nivel/compilador/asm/'

archivos_asm = glob.glob(os.path.join(base_path, '*.asm'))

for file in archivos_asm:
    cc.compilar(file)
