import numpy as np
import soundfile as sf
import sounddevice as sd

# Parameters
duration = 15  # seconds
sample_rate = 44100  # Hz
theta_freq = 6  # Hz (Theta wave frequency)
gamma_freq = 40  # Hz (Gamma wave frequency)
wobble_freq = 3  # Hz (Wobble modulation frequency)
modulation_depth = 0.5  # Depth of the wobble modulation (0.5 means 50% of the amplitude)
fm_depth = 0.1  # Frequency modulation depth for Theta wave

# Time array
t = np.linspace(0, duration, int(sample_rate * duration), endpoint=False)

# --- Generate Theta Wave (Left Channel) with Frequency & Amplitude Modulation ---

# Frequency Modulation (FM)
fm_wave = np.sin(2 * np.pi * wobble_freq * t) * fm_depth  # Slow wobble added to Theta frequency
theta_wave = np.sin(2 * np.pi * (theta_freq + fm_wave) * t)

# Amplitude Modulation (AM)
wobble = 1 - modulation_depth + modulation_depth * np.sin(2 * np.pi * wobble_freq * t)  # Amplitude modulation
theta_wave_modulated = theta_wave * wobble  # Apply AM to Theta wave

# --- Generate Gamma Wave (Right Channel) ---

# Basic Gamma sine wave
gamma_wave = np.sin(2 * np.pi * gamma_freq * t)

# --- Add Panning Effect (Gamma Wave Dynamic Stereo) ---
# Slowly pan the Gamma wave from right to left for immersive effect
pan_speed = 0.05  # Panning speed (how fast it moves)
pan_wave = np.sin(2 * np.pi * pan_speed * t)  # A sine wave to modulate panning
gamma_left = (1 + pan_wave) / 2 * gamma_wave  # Pan to left gradually
gamma_right = (1 - pan_wave) / 2 * gamma_wave  # Pan to right gradually

# --- Combine Waves into Stereo Channels ---
left_channel = theta_wave_modulated + gamma_left  # Left channel contains Theta + part of Gamma
right_channel = gamma_right  # Right channel contains Gamma, dynamically panned

stereo_sound = np.column_stack((left_channel, right_channel))

# Normalize to avoid clipping
stereo_sound *= 0.3 / np.max(np.abs(stereo_sound))

# --- Save to WAV file ---
sf.write('deep_theta_gamma_wobble.wav', stereo_sound, sample_rate)

# --- Play the sound ---
sd.play(stereo_sound, sample_rate)
sd.wait()  # Wait until playback finishes
