🌤 Weather App

A weather application built using **UIKit** that follows the structure of the Apple Weather app.  
The focus of this project is on building a clean architecture, reusable components, and handling real API data.

## Features

- Current Weather Display
- Hourly Forecast
- 10-Day Forecast (using static data as required)
- Additional Weather Info (humidity, visibility, sunrise, etc.)
- Search for cities
- Select specific day using calendar
- Dynamic background (day / night)
- Header animation while scrolling
- Loading indicator
- Error handling

## Architecture

The project is structured in a clean and simple way:

### Network Layer
- `NetworkManager` handles all API requests using a generic function

### Service Layer
- `WeatherService` manages endpoints and prepares requests

### ViewModel Layer
- `WeatherViewModel` handles business logic and data transformation

### UI Layer
- Built using **UIKit**
- Uses **XIBs** for views and cells
- No Storyboards used

## API

The app uses **OpenWeather API (v2.5)** to fetch:

- Current weather
- Forecast data

> Note: The 10-day forecast is implemented using static data based on the project requirement.

## Requirements

- UIKit only
- No Storyboards
- XIB-based UI
- Clean project structure
- Proper handling of loading and error states

## UI Inspiration

The UI is inspired by the native Apple Weather app.

## How to Run

1. Clone the project
2. Open it in Xcode
3. Run the app on simulator or real device

---

## Author

Azhar Ghurab
