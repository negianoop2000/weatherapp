## OpenWeather App

## Overview
OpenWeather is a simple weather forecast application built using Flutter. It allows users to log in using Gmail via Firebase Authentication, select a city from a dropdown list, and fetch real-time weather data using the OpenWeather API.

## Features
- **Gmail Login with Firebase**: Secure authentication using Firebase Authentication.
- **City Selection**: Dropdown with a list of cities to choose from.
- **Weather Information**: Displays temperature, humidity, wind speed, and overall weather conditions.
- **State Management**: Managed using Provider for efficient state handling.

## Screenshots
![WhatsApp Image 2025-03-24 at 2 58 04 PM](https://github.com/user-attachments/assets/69a1c778-03c8-4d4a-ac21-be87f9e27050)


## Technologies Used
- **Flutter**
- **Dart**
- **Firebase Authentication**
- **Provider (State Management)**
- **OpenWeather API**

## API Integration
This app uses the [OpenWeather API](https://openweathermap.org/api) to fetch real-time weather data. Ensure you have a valid API key.

## Installation
Follow these steps to set up the project on your local machine:

1. **Clone the repository**:
    ```bash
    git clone <repository_url>
    cd openweather_app
    ```

2. **Install dependencies**:
    ```bash
    flutter pub get
    ```

3. **Set up Firebase**:
    - Create a Firebase project.
    - Enable Authentication with Gmail.
    - Download the `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS).
    - Place it in the respective folders.

4. **Configure API Key**:
    - Get your API key from OpenWeather.
    - Add it to the `.env` file or directly in your code.

5. **Run the App**:
    ```bash
    flutter run
    ```

## Contributing
Contributions are welcome! Please fork the repository, make your changes, and create a pull request.

## License
This project is licensed under the MIT License. See the LICENSE file for details.

