# IoT Environment Monitoring System

This repository contains an Arduino-based environment monitoring system using ESP32 or ESP8266 microcontrollers, a DHT11 sensor for temperature and humidity measurement, and integration with Firebase Realtime Database. The system also displays sensor data on an OLED display and supports MQTT messaging for IoT communication.

## Features

- **Temperature and Humidity Monitoring**: Measures environmental data using a DHT11 sensor.
- **Firebase Integration**: Sends sensor data to Firebase Realtime Database.
- **OLED Display**: Displays the temperature and humidity readings on an Adafruit SSD1306 OLED screen.
- **MQTT Communication**: Supports MQTT messaging for IoT applications.
- **Wi-Fi Connectivity**: Works with ESP32 or ESP8266 microcontrollers for seamless Wi-Fi connection.

## Hardware Requirements

- ESP32 or ESP8266 microcontroller
- DHT11 temperature and humidity sensor
- Adafruit SSD1306 OLED display
- Jumper wires and breadboard for connections
- A Firebase project setup for integration

## Software Requirements

- **Arduino IDE** (latest version)
- **Firebase ESP32/ESP8266 Client Library**: For Firebase Realtime Database integration.
- **Adafruit SSD1306 Library**: For controlling the OLED display.
- **Adafruit MQTT Library**: For MQTT communication.
- **DHT Sensor Library**: For interfacing with the DHT11 sensor.

## Libraries Used

- [Firebase ESP Client](https://github.com/mobizt/Firebase-ESP8266)
- [DHT sensor library](https://github.com/adafruit/DHT-sensor-library)
- [Adafruit SSD1306](https://github.com/adafruit/Adafruit_SSD1306)
- [Adafruit MQTT](https://github.com/adafruit/Adafruit_MQTT_Library)

## How to Use

###  Set Up Your Firebase Project

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/).
2. Obtain your Firebase Realtime Database URL and Authentication Token.
3. Configure the `TokenHelper.h` file with your Firebase project details.

###  Connect Your Hardware

- Connect the **DHT11** sensor to the ESP32/ESP8266.
- Connect the **OLED Display** (Adafruit SSD1306) to your microcontroller.
- Connect the **ESP32/ESP8266** to your Wi-Fi network.

###  Upload the Code

1. Clone or download this repository.
2. Open the Arduino IDE and load the appropriate sketch for your microcontroller (either ESP32 or ESP8266).
3. Upload the sketch to your ESP32/ESP8266 device.
4. Ensure that the device is connected to your Wi-Fi and able to send data to Firebase.

###  Monitor the Data

Once uploaded, the system will:
- Measure temperature and humidity from the DHT11 sensor.
- Display the readings on the OLED screen.
- Send the data to Firebase Realtime Database.
- Publish sensor data via MQTT (optional).


## Customization

- Modify the Wi-Fi credentials in the code.
- Adjust the sensor reading interval as needed.
- Customize the OLED display messages to suit your project.

## Troubleshooting

- Ensure that all connections are correct and there are no loose wires.
- Make sure the Firebase token is valid and correctly set in the code.
- If you encounter Wi-Fi issues, verify the network credentials and signal strength.

  ## This is how the project looks at the end
  ![WhatsApp Image 2024-11-24 at 22 30 28_61c684d2](https://github.com/user-attachments/assets/2cd084fb-324f-4db7-951b-060682c5ffde)

   ![WhatsApp Image 2024-11-24 at 22 29 39_c711e282](https://github.com/user-attachments/assets/9ea60fdf-b37d-40af-b703-688e758fc650)
  ![image](https://github.com/user-attachments/assets/99f9bc60-fa15-414f-a167-8946a86a03e6)

  



### Acknowledgements

- **Firebase ESP Client**: For providing a simple interface to connect to Firebase.
- **Adafruit Libraries**: For providing easy-to-use libraries for the OLED display and MQTT communication.


