# Google Maps Setup Guide

To enable Google Maps in the Convoy Travel App, you need to set up a Google Maps API key.

## Steps to Setup Google Maps API

### 1. Get Google Maps API Key

1. Go to the [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing project
3. Enable the following APIs:
   - Maps SDK for iOS
   - Maps SDK for Android
   - Places API (if using place search)
   - Directions API (if using routing)

4. Create credentials:
   - Go to "Credentials" in the left sidebar
   - Click "Create Credentials" > "API Key"
   - Copy your API key

### 2. Configure iOS (Required for iPhone)

1. Open `ios/Runner/Info.plist`
2. Replace `YOUR_GOOGLE_MAPS_API_KEY_HERE` with your actual API key:

```xml
<key>GMSApiKey</key>
<string>AIzaSyC4E1Dxi-PH4KkhQHYE9BqCeKdcCcP6Fk0</string>
```

### 3. Configure Android (if needed)

1. Open `android/app/src/main/AndroidManifest.xml`
2. Add your API key inside the `<application>` tag:

```xml
<meta-data android:name="com.google.android.geo.API_KEY"
           android:value="YOUR_GOOGLE_MAPS_API_KEY_HERE"/>
```

### 4. Security (Important)

For production apps, restrict your API key:

1. In Google Cloud Console, click on your API key
2. Under "Application restrictions", select:
   - **iOS apps** for iOS bundle ID: `com.example.convoyTravelApp`
   - **Android apps** for Android package name and SHA-1 certificate fingerprint

3. Under "API restrictions", select "Restrict key" and choose only the APIs you need

## Demo Configuration

For this demo app, the Google Maps widget is configured with:

- **Initial location**: Mumbai, India (19.0760, 72.8777)
- **Zoom level**: 11.0
- **Features enabled**: 
  - Vehicle markers (green = online, red = offline)
  - User location
  - Map gestures (zoom, pan, rotate)
  - Compass
  - Vehicle count overlay
  - Center on convoy button

## Troubleshooting

### Map not showing
- Check that your API key is correctly set in `Info.plist`
- Ensure Maps SDK for iOS is enabled in Google Cloud Console
- Check iOS simulator internet connection

### Markers not appearing
- Verify vehicle data has valid latitude/longitude coordinates
- Check that mock data service provides location data for vehicles

### Location permission issues
- The app requests location permissions for "When In Use"
- Grant permission when prompted in iOS simulator

## Current Demo Data

The app includes mock data with vehicles positioned around Mumbai:
- **Vehicle 1**: Priya's Honda City (19.0760, 72.8777)
- **Vehicle 2**: Rohan's Toyota Innova (19.0820, 72.8850) 
- **Vehicle 3**: Aisha's Maruti Swift (19.0700, 72.8720)

All vehicles show as online with green markers and include driver information in marker info windows. 