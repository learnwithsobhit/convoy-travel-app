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

### Demo Users & Login

The app includes comprehensive demo users for testing different user experiences. You can login as any user type to explore specific features:

#### ⚡ **Quick Demo Access**

| 🚀 **Role** | 📧 **Email** | 🔑 **Password** | 🎯 **Best For** |
|-------------|--------------|-----------------|------------------|
| Trip Leader | `priya@example.com` | `leader123` | Full app management |
| Driver | `rohan@example.com` | `driver123` | Vehicle & navigation |
| Passenger | `aisha@example.com` | `pass123` | Games & entertainment |
| Emergency | `rajesh@example.com` | `emergency123` | Safety monitoring |

> 💡 **Quick Start**: Use Trip Leader credentials for the complete experience!

#### 🚗 **Driver Users**
- **Rohan Kumar** (`rohan@example.com`)
  - Role: Driver with vehicle management features
  - Vehicle: SUV (vehicle_2)
  - Status: Currently driving
  - Features: Navigation, quick alerts, voice chat

- **Vikram Singh** (`vikram@example.com`)
  - Role: Driver with convoy coordination
  - Vehicle: Sedan (vehicle_3)
  - Status: Currently driving
  - Features: Real-time tracking, communication

#### 👥 **Passenger Users**
- **Aisha Patel** (`aisha@example.com`)
  - Role: Passenger focused on entertainment
  - Vehicle: Travels with Priya (vehicle_1)
  - Features: Games, photo sharing, group chat

- **Maya Reddy** (`maya@example.com`)
  - Role: Passenger with social features
  - Vehicle: Travels with Rohan (vehicle_2)
  - Features: Interactive games, messaging

- **Ankit Gupta** (`ankit@example.com`)
  - Role: General passenger
  - Vehicle: Travels with Vikram (vehicle_3)

- **Sneha Joshi** (`sneha@example.com`)
  - Role: Social passenger
  - Features: Group activities, communication

#### 👑 **Trip Leader**
- **Priya Sharma** (`priya@example.com`)
  - Role: Trip organizer and leader
  - Vehicle: Lead vehicle (vehicle_1)
  - Features: Full trip management, convoy monitoring, emergency coordination
  - Permissions: Create trips, manage participants, end trips

#### 🚨 **Emergency Contact**
- **Rajesh Sharma** (`rajesh@example.com`)
  - Role: Emergency contact for safety
  - Features: Receives emergency alerts, trip status updates
  - Permissions: Monitor trip safety, receive notifications

#### 🔑 **Login Credentials**

You can use these specific demo user credentials to login and test different user experiences:

| User Type | Email | Password | User Name | Role |
|-----------|-------|----------|-----------|------|
| **Trip Leader** | `priya@example.com` | `leader123` | Priya Sharma | Full trip management |
| **Driver** | `rohan@example.com` | `driver123` | Rohan Kumar | Vehicle management |
| **Driver** | `vikram@example.com` | `driver456` | Vikram Singh | Convoy coordination |
| **Passenger** | `aisha@example.com` | `pass123` | Aisha Patel | Entertainment features |
| **Passenger** | `maya@example.com` | `pass456` | Maya Reddy | Social features |
| **Passenger** | `ankit@example.com` | `pass789` | Ankit Gupta | General passenger |
| **Emergency Contact** | `rajesh@example.com` | `emergency123` | Rajesh Sharma | Safety monitoring |

#### 📱 **How to Login**

**Method 1: Direct User Credentials**
1. **Enter specific email/password** from the table above
2. **Select corresponding user type** from dropdown
3. **Tap Login** to access that user's experience

**Method 2: Quick User Type Selection**
1. **Select any user type** from the dropdown:
   - `Trip Leader` - Auto-assigns Priya Sharma
   - `Driver` - Auto-assigns Rohan Kumar  
   - `Passenger` - Auto-assigns Aisha Patel
   - `Emergency Contact` - Auto-assigns Rajesh Sharma
2. **Enter any email/password** (authentication is simulated)
3. **Tap Login** to access features for that user type

#### 🎯 **Recommended Testing Flow**

1. **Start as Trip Leader** (`priya@example.com` / `leader123`)
   - Create or view existing trips
   - Monitor convoy dashboard
   - Access all management features

2. **Switch to Driver** (`rohan@example.com` / `driver123`)
   - Experience vehicle tracking
   - Use quick alerts and communication
   - See driver-specific navigation

3. **Try Passenger** (`aisha@example.com` / `pass123`)
   - Explore entertainment features
   - Play interactive games
   - Use group chat features

4. **Test Emergency Contact** (`rajesh@example.com` / `emergency123`)
   - Monitor trip safety
   - Receive emergency notifications
   - View trip status updates

#### 💡 **Quick Start Tips**

- **Try Driver mode** to see vehicle tracking and navigation features
- **Use Passenger mode** to explore games and entertainment
- **Select Trip Leader** for full management capabilities
- **Test Emergency Contact** to see safety monitoring features

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