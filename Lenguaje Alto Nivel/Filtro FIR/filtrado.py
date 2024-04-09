import numpy as np
import wave
import struct
from scipy.signal import firwin2, freqz


def generate_coefficients(fs, cutoff_freq, transition_width, filter_length):
    """
    Generate FIR filter coefficients using the firwin function.
    
    Args:
        fs (float): Sampling rate of the audio signal.
        cutoff_freq (float): Cutoff frequency of the low-pass filter.
        filter_length (int): Length of the FIR filter.
    
    Returns:
        ndarray: FIR filter coefficients.
    """
    nyquist = fs / 2
    freqs = [0, cutoff_freq - transition_width/2, cutoff_freq + transition_width/2, nyquist]
    gains = [1, 1, 0, 0]
    coefficients = firwin2(filter_length, freqs, gains, fs=fs)
    
    return coefficients

def convolve(x, b):
    """
    Perform FIR filtering on the input signal.
    
    Args:
        x (ndarray): Input signal.
        b (ndarray): FIR filter coefficients.
    
    Returns:
        ndarray: Filtered output signal.
    """
    N_x = len(x)
    N_b = len(b)
    
    y = [0] * N_x
    for n in range(N_x):
        acc = 0
        for k in range(N_b):
            acc += b[k] * x[n-k]
        y[n] = acc
    
    return y

# Cargar archivo de audio WAV de entrada
input_wav = wave.open("MerryChristmasInput.wav", "r")
num_channels = input_wav.getnchannels()
sample_width = input_wav.getsampwidth()
sample_rate = input_wav.getframerate()
num_frames = input_wav.getnframes()

# Leer muestras de audio como vector binario
input_data = input_wav.readframes(num_frames)
input_data = struct.unpack(f"{num_frames * num_channels}h", input_data)
input_data = np.array(input_data)

# Definir coeficientes FIR, 8 coeficientes
coefficients = generate_coefficients(sample_rate, 1500, 500, 8)

# Definir coeficientes FIR, 16 coeficientes
coefficients2 = generate_coefficients(sample_rate, 1500, 500, 16)

# Realizar convolución con los coeficientes FIR
output_data = convolve(input_data, coefficients2)
output_data = np.round(output_data).astype(np.int16)

# Crear nuevo archivo WAV de salida
output_wav = wave.open("MerryChristmasOutput.wav", "w")
output_wav.setnchannels(num_channels)
output_wav.setsampwidth(sample_width)
output_wav.setframerate(sample_rate)
output_wav.writeframes(struct.pack(f"{len(output_data)}h", *output_data))

# Imprimir para uso luego
print(coefficients)
print(coefficients2)

# Imprimir datos para prueba
print(input_data[8000], input_data[8001], input_data[8002])
print(output_data[8000], output_data[8001], output_data[8002])

# Cerrar archivos
input_wav.close()
output_wav.close()