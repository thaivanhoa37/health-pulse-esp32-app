import time
from machine import SoftI2C, Pin, PWM
from max30102 import MAX30102, MAX30105_PULSE_AMP_MEDIUM
from ssd1306 import SSD1306_I2C
from utime import ticks_diff, ticks_us

i2c_display = SoftI2C(sda=Pin(21), scl=Pin(22))  # SDA -> GPIO4, SCL -> GPIO5
oled_width = 128
oled_height = 64
oled = SSD1306_I2C(oled_width, oled_height, i2c_display)

# MAX30102 sensor setup
i2c_sensor = SoftI2C(sda=Pin(21), scl=Pin(22), freq=400000)
sensor = MAX30102(i2c=i2c_sensor)

# Buzzer setup
buzzer = PWM(Pin(15))  # Buzzer connected to GPIO15
buzzer.freq(1000)  # Set frequency to 1kHz
buzzer.duty(0)  # Initially turn off the buzzer

# Scan I2C bus to ensure that the sensor is connected
if sensor.i2c_address not in i2c_sensor.scan():
    print("Sensor not found.")
    oled.text("Sensor not found", 0, 0)
    oled.show()
    time.sleep(5)

elif not (sensor.check_part_id()):
    # Check that the targeted sensor is compatible
    print("I2C device ID not corresponding to MAX30102 or MAX30105.")
    oled.text("Invalid sensor", 0, 0)
    oled.show()
    time.sleep(5)
else:
    print("Sensor connected and recognized.")
    oled.text("Sensor connected", 0, 0)
    oled.show()
    time.sleep(2)

# Setup the sensor
sensor.setup_sensor()
sensor.set_sample_rate(400)
sensor.set_fifo_average(8)
sensor.set_active_leds_amplitude(MAX30105_PULSE_AMP_MEDIUM)
sensor.set_led_mode(2)
time.sleep(1)

# Variables to store readings
MAX_HISTORY = 32
history = []
beats_history = []
spo2_history = []
beat = False
beats = 0
spo2 = 0

t_start = ticks_us()  # Starting time of the acquisition

def calculate_spo2(red, ir):
    try:
        # Calculate the AC/DC ratio for RED and IR
        red_dc = sum(red) / len(red)
        ir_dc = sum(ir) / len(ir)
        red_ac = max(red) - min(red)
        ir_ac = max(ir) - min(ir)

        # Calculate SpO2 (approximate value - formula can be fine-tuned)
        ratio = (red_ac / red_dc) / (ir_ac / ir_dc)
        spo2 = 110 - (ratio * 25)  # Constant might need adjustment for actual sensor
        return max(0, min(100, spo2))  # Limit value from 0 to 100%
    except ZeroDivisionError:
        return 0

red_values = []
ir_values = []

while True:
    # Polling sensor for new data
    sensor.check()

    if sensor.available():
        red_reading = sensor.pop_red_from_storage()
        ir_reading = sensor.pop_ir_from_storage()

        value = red_reading
        history.append(value)
        red_values.append(red_reading)
        ir_values.append(ir_reading)

        # Keep history length fixed
        history = history[-MAX_HISTORY:]
        red_values = red_values[-MAX_HISTORY:]
        ir_values = ir_values[-MAX_HISTORY:]

        minima, maxima = min(history), max(history)
        threshold_on = (minima + maxima * 3) // 4   # 3/4
        threshold_off = (minima + maxima) // 2      # 1/2

        if value > 1000:
            if not beat and value > threshold_on:
                beat = True
                t_us = ticks_diff(ticks_us(), t_start)
                t_s = t_us / 1000000
                f = 1 / t_s
                bpm = f * 60
                if bpm < 500:
                    t_start = ticks_us()
                    beats_history.append(bpm)
                    beats_history = beats_history[-MAX_HISTORY:]
                    beats = round(sum(beats_history) / len(beats_history), 2)

                    # Calculate SpO2
                    spo2 = calculate_spo2(red_values, ir_values)
                    spo2_history.append(spo2)
                    spo2_history = spo2_history[-MAX_HISTORY:]
                    spo2 = round(sum(spo2_history) / len(spo2_history), 2)

                    # Display BPM and SpO2 on OLED
                    oled.fill(0)
                    oled.text(f"BPM: {beats}", 0, 16)
                    oled.text(f"SpO2: {spo2}%", 0, 32)
                    oled.show()

                    # Make buzzer beep in a heartbeat-like pattern
                    buzzer.duty(512)  # Turn on the buzzer
                    time.sleep(0.05)  # Short beep for heartbeat sound
                    buzzer.duty(0)  # Turn off the buzzer
                    time.sleep(0.2)  # Pause between beats
                    buzzer.duty(512)  # Second short beep
                    time.sleep(0.05)
                    buzzer.duty(0)

            if beat and value < threshold_off:
                beat = False

        else:
            buzzer.duty(0)  # Turn off the buzzer
            oled.fill(0)
            oled.text("Not finger", 0, 24)
            oled.show()

