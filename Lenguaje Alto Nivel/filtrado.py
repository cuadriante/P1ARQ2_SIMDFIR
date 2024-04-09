import numpy as np
from scipy.io import wavfile

def high_pass_filter(input_signal, alpha=0.1):
    # Check for NaN or Inf values in the input and replace them
    if np.any(np.isnan(input_signal)) or np.any(np.isinf(input_signal)):
        print("Warning: NaN or Inf found in input signal, replacing with zeros.")
        input_signal = np.nan_to_num(input_signal)  # Replace NaN and Inf with zeros
    
    
    output_signal = np.zeros_like(input_signal)
    for n in range(1, len(input_signal), 2):  # 2 a la vez
        output_signal[n] = input_signal[n] - alpha * input_signal[n - 1]
        output_signal[n+1] = input_signal[n+1] - alpha * input_signal[n]
    return output_signal


def save_output_to_wav(output_signal, sample_rate):
    # Check for NaN or Inf in the output signal
    if np.any(np.isnan(output_signal)) or np.any(np.isinf(output_signal)):
        print("Warning: NaN or Inf found in output signal, replacing with zeros.")
        output_signal = np.nan_to_num(output_signal)

    max_val = np.max(np.abs(output_signal))
    if max_val > 0:
        normalized_signal = output_signal / max_val
    else:
        print("Warning: Max value of output signal is zero, normalization skipped.")
        normalized_signal = output_signal


    signal_to_write = np.int16(normalized_signal * 32767)
    wavfile.write('output.wav', sample_rate, signal_to_write)

def main():
    # Convert the input WAV file to binary
    try:
        sample_rate, audio_data = wavfile.read("tada.wav")
        audio_data_float32 = audio_data.astype(np.float32)
        with open("tada.bin", "wb") as file:
            audio_data_float32.tofile(file)
    except IOError as e:
        print(f"Unable to open or write to file: {e}")
        return 1


    try:
        with open("tada.bin", "rb") as file:
            input_signal = np.fromfile(file, dtype=np.float32)
    except IOError as e:
        print(f"Unable to open file: {e}")
        return 1

    output_signal = high_pass_filter(input_signal)

    sample_rate = 44100  # Adjust this to match the sample rate of the original file
    save_output_to_wav(output_signal, sample_rate)

    print("Processing complete. Output saved as 'output.wav'.")

    return 0

if __name__ == "__main__":
    main()
