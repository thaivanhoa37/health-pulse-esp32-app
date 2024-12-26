import time
import network
from machine import SoftI2C, Pin, PWM
from max30102 import MAX30102, MAX30105_PULSE_AMP_MEDIUM
from ssd1306 import SSD1306_I2C
from utime import ticks_diff, ticks_us
import urequests
import random

# Configuration
ssid = 'vanhoa'
password = '244466666'
FIREBASE_HOST = "https://myhealth-96db3-default-rtdb.asia-southeast1.firebasedatabase.app/"
FIREBASE_AUTH = "7QhP86mtNtocHxCeHupGUuqjsrERokp53QmeirWJ"

# I2C and sensor setup
i2c_display = SoftI2C(sda=Pin(21), scl=Pin(22))
oled_width = 128
oled_height = 64
oled = SSD1306_I2C(oled_width, oled_height, i2c_display)

i2c_sensor = SoftI2C(sda=Pin(21), scl=Pin(22), freq=400000)
sensor = MAX30102(i2c=i2c_sensor)

buzzer = PWM(Pin(15))
buzzer.freq(1000)
buzzer.duty(0)

# Check sensor connection
if sensor.i2c_address not in i2c_sensor.scan():
    print("Sensor not found.")
    oled.text("Sensor not found", 0, 0)
    oled.show()
    time.sleep(5)
elif not (sensor.check_part_id()):
    print("I2C device ID not corresponding to MAX30102 or MAX30105.")
    oled.text("Invalid sensor", 0, 0)
    oled.show()
    time.sleep(5)
else:
    print("Sensor connected and recognized.")
    oled.text("Sensor connected", 0, 0)
    oled.show()
    time.sleep(2)

sensor.setup_sensor()
sensor.set_sample_rate(400)
sensor.set_fifo_average(8)
sensor.set_active_leds_amplitude(MAX30105_PULSE_AMP_MEDIUM)
sensor.set_led_mode(2)
time.sleep(1)

MAX_HISTORY = 32
history = []
beats_history = []
spo2_history = []
beat = False
beats = 0
spo2 = 0
t_start = ticks_us()

def calculate_spo2(red, ir):
    try:
        red_dc = sum(red) / len(red)
        ir_dc = sum(ir) / len(ir)
        red_ac = max(red) - min(red)
        ir_ac = max(ir) - min(ir)
        ratio = (red_ac / red_dc) / (ir_ac / ir_dc)
        spo2 = 110 - (ratio * 20)  # Adjusted constant for better accuracy
        return max(0, min(100, spo2))
    except ZeroDivisionError:
        return 0

red_values = []
ir_values = []

def connect_wifi():
    wlan = network.WLAN(network.STA_IF)
    wlan.active(True)
    wlan.connect(ssid, password)
    while not wlan.isconnected():
        time.sleep(1)
    print("Connected to WiFi")
    print("IP address:", wlan.ifconfig()[0])

def send_to_firebase(path, data):
    try:
        url = f"{FIREBASE_HOST}{path}.json?auth={FIREBASE_AUTH}"
        response = urequests.put(url, json=data)
        print(f"Data sent to Firebase: {response.text}")
        response.close()
    except Exception as e:
        print(f"Error sending data to Firebase: {e}")

def send_warning_to_firebase(type, value):
    time_now = time.localtime()
    path = f"1/pic/{time_now[3]}:{time_now[4]}:{time_now[5]}"
    data = {
        "type": type,
        "valeur": value,
        "temps": f"{time_now[3]}:{time_now[4]}:{time_now[5]} {time_now[2]}/{time_now[1]}/{time_now[0]}"
    }
    send_to_firebase(path, data)

connect_wifi()

def calculate_bpm():
    global t_start, beats, beats_history, red_values
    if len(red_values) < 2:
        return
    peak_intervals = []
    for i in range(1, len(red_values)):
        if red_values[i] > threshold_on and red_values[i-1] <= threshold_on:
            t_peak = ticks_diff(ticks_us(), t_start) / 1000000
            peak_intervals.append(t_peak)
            t_start = ticks_us()
    if peak_intervals:
        average_interval = sum(peak_intervals) / len(peak_intervals)
        bpm = 60 / average_interval
        beats_history.append(bpm)
        beats_history = beats_history[-MAX_HISTORY:]
        beats = round(sum(beats_history) / len(beats_history), 2)
        print(f"Calculated BPM: {beats}")

def adjust_thresholds(history):
    minima, maxima = min(history), max(history)
    threshold_on = (minima + maxima * 3) // 4
    threshold_off = (minima + maxima) // 2
    return threshold_on, threshold_off

while True:
    sensor.check()
    if sensor.available():
        red_reading = sensor.pop_red_from_storage()
        ir_reading = sensor.pop_ir_from_storage()
        value = red_reading
        history.append(value)
        red_values.append(red_reading)
        ir_values.append(ir_reading)
        history = history[-MAX_HISTORY:]
        red_values = red_values[-MAX_HISTORY:]
        ir_values = ir_values[-MAX_HISTORY:]
        threshold_on, threshold_off = adjust_thresholds(history)
        if value > 1000:
            if not beat and value > threshold_on:
                beat = True
                calculate_bpm()
                spo2 = calculate_spo2(red_values, ir_values)
                spo2_history.append(spo2)
                spo2_history = spo2_history[-MAX_HISTORY:]
                spo2 = round(sum(spo2_history) / len(spo2_history), 2)
                send_to_firebase("1/heartRate", beats)
                send_to_firebase("1/spo2", spo2)
                oled.fill(0)
                oled.text(f"BPM: {beats}", 0, 16)
                oled.text(f"SpO2: {spo2}%", 0, 32)
                oled.show()
                if spo2 < 95:
                    send_warning_to_firebase("SpO2", spo2)
                if beats < 60 or beats > 100:
                    send_warning_to_firebase("BPM", beats)
                buzzer.duty(512)
                time.sleep(0.05)
                buzzer.duty(0)
                time.sleep(0.2)
                buzzer.duty(512)
                time.sleep(0.05)
                buzzer.duty(0)
            if beat and value < threshold_off:
                beat = False
        else:
            buzzer.duty(0)
            oled.fill(0)
            oled.text("Not finger", 30, 30)
            oled.show()
    #time.sleep(1)
