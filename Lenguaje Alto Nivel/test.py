import numpy as np
import wave
import struct

def convolve(x, b):
    N_x = len(x)
    N_b = len(b)
    y = [0] * N_x  # Inicializar vector de salida con ceros

    for n in range(N_x):
        acc = 0
        for k in range(N_b):
            acc += b[k] * x[n-k]
        y[n] = acc

    return y

# Cargar archivo de audio WAV de entrada
input_wav = wave.open("test.wav", "r")
num_channels = input_wav.getnchannels()
sample_width = input_wav.getsampwidth()
sample_rate = input_wav.getframerate()
num_frames = input_wav.getnframes()

print(f"{num_frames}, {num_channels}")

# Leer muestras de audio como vector binario
input_data = input_wav.readframes(num_frames)
input_data = struct.unpack(f"{num_frames * num_channels}h", input_data)
input_data = np.array(input_data)

# Definir coeficientes FIR
b =  [
    0.029183359514055443,
    0.029779744780144553,
    0.030341314035934788,
    0.030866756254078743,
    0.031354842164334006,
    0.031804427695546707,
    0.032214457182525101,
    0.032583966327994970,
    0.032912084910572369,
    0.033198039230461426,
    0.033441154285384696,
    0.033640855670076741,
    0.033796671193517147,
    0.033908232208942304,
    0.033975274652555849,
    0.033997639787750347,
    0.033975274652555849,
    0.033908232208942304,
    0.033796671193517147,
    0.033640855670076741,
    0.033441154285384696,
    0.033198039230461426,
    0.032912084910572369,
    0.032583966327994970,
    0.032214457182525101,
    0.031804427695546707,
    0.031354842164334006,
    0.030866756254078743,
    0.030341314035934788,
    0.029779744780144553,
    0.029183359514055443,
]

# Realizar convolución con los coeficientes FIR
output_data = convolve(input_data, b)
output_data = np.round(output_data).astype(np.int16)

'''for i in range(10000, 11000):
    print(f"{input_data[i]}, {output_data[i]}")'''

print(f"{len(output_data)}, {len(input_data)}")
# Crear nuevo archivo WAV de salida
output_wav = wave.open("output.wav", "w")
output_wav.setnchannels(num_channels)
output_wav.setsampwidth(sample_width)
output_wav.setframerate(sample_rate)
output_wav.writeframes(struct.pack(f"{len(output_data)}h", *output_data))

# Cerrar archivos
input_wav.close()
output_wav.close()