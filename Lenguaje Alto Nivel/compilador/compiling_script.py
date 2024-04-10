import compiler_core as cc

base_path = r'Lenguaje Alto Nivel/compilador/asm/'

archivos_asm = [
    'inputEqual16.asm',
    'inputOver16.asm',
    'inputUnder16.asm',
    'inputNoSIMD.asm'
]

for nombre_archivo in archivos_asm:
    camino_completo = f"{base_path}{nombre_archivo}"
    cc.compilar(camino_completo)
