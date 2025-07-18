# Convoy Travel App

A comprehensive Flutter application for organizing and managing group travel experiences. Perfect for road trips, motorcycle rides, RV journeys, and any group travel adventure.

## Features

### 🚗 Trip Management
- **Create Trips**: Set up new group travel adventures with routes and details
- **Join Trips**: Use join codes to participate in existing trips
- **Trip Dashboard**: Real-time trip monitoring and management
- **Live Tracking**: Monitor convoy vehicles in real-time
- **Trip Statistics**: Track distance, duration, participants, and vehicles

### 👥 User Management
- **Multiple User Types**: Support for riders, drivers, passengers, and trip organizers
- **User Profiles**: Comprehensive profile management
- **Trip History**: View past trips and experiences

### 💬 Communication
- **Group Chat**: Real-time messaging between convoy members
- **Quick Alerts**: Send instant alerts for road conditions, stops, emergencies
- **Emergency Button**: One-tap emergency assistance

### 🎮 Entertainment
- **Interactive Games**: Road trip bingo, license plate games, trivia challenges
- **Photo Scavenger Hunt**: Capture memories along the way
- **Story Building**: Collaborative storytelling during the journey

### ⚙️ Settings & Customization
- **Notifications**: Customizable trip updates and alerts
- **Location Sharing**: Control location visibility within the group
- **Voice Chat**: Enable voice communication (coming soon)
- **Emergency Contacts**: Manage emergency contact information

## Screenshots

*Screenshots will be added here*

## Tech Stack

- **Framework**: Flutter 3.19.4+
- **State Management**: Provider
- **UI Components**: Material Design 3
- **Maps**: Google Maps (integration ready)
- **Icons**: Material Design Icons Flutter
- **Typography**: Google Fonts (Inter)

## Getting Started

### Prerequisites

- Flutter SDK 3.10.0 or higher
- Dart SDK 3.0.0 or higher
- iOS 11.0+ / Android API level 21+

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/convoy-travel-app.git
   cd convoy-travel-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For iOS
   flutter run -d ios
   
   # For Android
   flutter run -d android
   
   # For Web
   flutter run -d chrome
   ```

### Development Setup

1. **Enable platforms**
   ```bash
   flutter config --enable-web
   flutter config --enable-ios
   flutter config --enable-android
   ```

2. **Generate platform files** (if needed)
   ```bash
   flutter create --platforms=web,ios,android .
   ```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── constants/               # App constants and themes
│   ├── app_colors.dart
│   └── app_theme.dart
├── models/                  # Data models
│   ├── trip.dart
│   ├── user.dart
│   ├── vehicle.dart
│   ├── message.dart
│   └── index.dart
├── providers/               # State management
│   └── app_provider.dart
├── screens/                 # UI screens
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── profile_screen.dart
│   ├── create_trip_screen.dart
│   ├── join_trip_screen.dart
│   └── trip_dashboard_screen.dart
├── services/                # Business logic and APIs
│   └── mock_data_service.dart
└── widgets/                 # Reusable components
    ├── custom_button.dart
    ├── trip_history_card.dart
    ├── vehicle_tracking_widget.dart
    ├── trip_chat_widget.dart
    ├── quick_alerts_widget.dart
    └── emergency_button_widget.dart
```

## Demo Data

The app includes comprehensive mock data for testing:

- **Users**: Various user types (riders, drivers, passengers, organizers)
- **Trips**: Sample trips with different statuses and routes
- **Vehicles**: Different vehicle types with tracking data
- **Messages**: Sample chat conversations and alerts

### Demo Trip Codes

- `TRIP12345` - Active road trip
- `COFFEE123` - Coffee shop meetup
- `RIVER2024` - Planning stage river trip

### Demo Login

- **Rider**: Use rider credentials to experience convoy member features
- **Driver**: Use driver credentials to see vehicle management options
- **Organizer**: Use organizer credentials for full trip management

## Docker Support

The app includes Docker configuration for web deployment:

```bash
# Build Docker image
docker build -t convoy-travel-app .

# Run with Docker Compose
docker-compose up
```

The web version will be available at `http://localhost:8080`

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Flutter team for the amazing framework
- Material Design team for the design system
- Google Fonts for typography
- All contributors and testers

## Contact

For questions, suggestions, or support:

- Email: your-email@example.com
- GitHub Issues: [Create an issue](https://github.com/yourusername/convoy-travel-app/issues)

---

**Happy Travels! 🚗✨**

*Built with ❤️ using Flutter* 