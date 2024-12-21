# Joke App

A Flutter application that fetches and displays jokes. The app supports caching jokes using `SharedPreferences` to provide offline access.

## Features

- Fetch jokes from an API
- Display jokes in a list
- Pull to refresh to fetch new jokes
- Cache jokes for offline access

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) installed on your machine
- [Dart](https://dart.dev/get-dart) installed on your machine

### Running the App

1. Connect your device or start an emulator.
2. Run the app:
   ```sh
   flutter run
   ```

## Project Structure

- `lib/main.dart`: The main entry point of the application.
- `lib/joke_service.dart`: Service class to fetch and cache jokes.
- `lib/joke_card.dart`: Widget to display individual jokes.
- `lib/joke_model.dart`: Model class for jokes.

## Dependencies

- `flutter`
- `shared_preferences`
- `dio`
- `liquid_pull_to_refresh`