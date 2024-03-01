import numpy as np
from scipy.io import wavfile

def high_pass_filter(input_signal, alpha=0.95):  # Adjust alpha to tweak the filter effect
    output_signal = np.zeros_like(input_signal)
    for n in range(1, len(input_signal)):
        output_signal[n] = alpha * (output_signal[n-1] + input_signal[n] - input_signal[n-1])
    return output_signal

def save_output_to_wav(output_signal, sample_rate):
    max_val = np.max(np.abs(output_signal))
    if max_val > 0:
        normalized_signal = (output_signal / max_val) * 32767  # Normalize to 16-bit range
    else:
        normalized_signal = output_signal
    signal_to_write = normalized_signal.astype(np.int16)
    wavfile.write('output.wav', sample_rate, signal_to_write)

def main():
    try:
        with open("tada.bin", "rb") as file:
            input_signal = np.fromfile(file, dtype=np.float32)
    except IOError as e:
        print(f"Unable to open file: {e}")
        return 1

    output_signal = high_pass_filter(input_signal, alpha=0.95)  # Adjust alpha as needed

    sample_rate = 44100  # Use the actual sample rate of the original audio if known
    save_output_to_wav(output_signal, sample_rate)

    print("Processing complete. Output saved as 'output.wav'.")

    return 0

if __name__ == "__main__":
    main()
