import 'package:flutter/foundation.dart';
import '../models/index.dart';
import '../services/mock_data_service.dart';

class AppProvider extends ChangeNotifier {
  // Current user
  User? _currentUser;
  User? get currentUser => _currentUser;

  // User type (for login screen)
  String _userType = 'Driver';
  String get userType => _userType;

  // Current active trip
  Trip? _activeTrip;
  Trip? get activeTrip => _activeTrip;

  // Trip data
  List<User> _tripParticipants = [];
  List<Vehicle> _tripVehicles = [];
  List<Message> _tripMessages = [];

  List<User> get tripParticipants => List.unmodifiable(_tripParticipants);
  List<Vehicle> get tripVehicles => List.unmodifiable(_tripVehicles);
  List<Message> get tripMessages => List.unmodifiable(_tripMessages);

  // All available trips
  List<Trip> get trips {
    MockDataService.initialize(); // Ensure data is initialized
    return MockDataService.trips;
  }

  // App state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Location tracking
  bool _isLocationUpdateEnabled = false;
  bool get isLocationUpdateEnabled => _isLocationUpdateEnabled;

  // Notification settings
  bool _notificationsEnabled = true;
  bool get notificationsEnabled => _notificationsEnabled;

  // Voice chat state
  bool _isVoiceChatActive = false;
  bool get isVoiceChatActive => _isVoiceChatActive;

  AppProvider() {
    _initialize();
  }

  void _initialize() {
    // Initialize mock data service first
    MockDataService.initialize();
    
    // Initialize with mock data
    _currentUser = MockDataService.currentUser;
    _loadActiveTrip();
  }

  void _loadActiveTrip() {
    if (_currentUser != null) {
      _activeTrip = MockDataService.getActiveTripForUser(_currentUser!.id);
      if (_activeTrip != null) {
        _loadTripData();
      }
      notifyListeners(); // Ensure UI updates even if no active trip
    }
  }

  void _loadTripData() {
    if (_activeTrip != null) {
      _tripParticipants = MockDataService.getUsersForTrip(_activeTrip!.id);
      _tripVehicles = MockDataService.getVehiclesForTrip(_activeTrip!.id);
      _tripMessages = MockDataService.getMessagesForTrip(_activeTrip!.id);
      notifyListeners();
    }
  }

  // Trip management
  Future<void> joinTrip(String joinCode) async {
    setLoading(true);
    clearError();
    
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 1500));
      
      // Find trip by join code
      final availableTrips = MockDataService.trips;
      Trip? foundTrip;
      
      for (final trip in availableTrips) {
        if (trip.joinCode.toUpperCase() == joinCode.toUpperCase()) {
          foundTrip = trip;
          break;
        }
      }
      
      if (foundTrip == null) {
        throw Exception('Trip not found. Please check the join code: $joinCode');
      }
      
      if (!foundTrip.canJoin) {
        throw Exception('This trip is no longer accepting new members.');
      }
      
      // Check if user is already a participant
      if (foundTrip.isParticipant(_currentUser?.id ?? '')) {
        // User is already in the trip, just set as active
        _activeTrip = foundTrip;
      } else {
        // Add user to trip (in real app, this would be an API call)
        _activeTrip = foundTrip.addParticipant(_currentUser?.id ?? '');
      }
      
      _loadTripData();
      clearError();
      
    } catch (e) {
      setError('Failed to join trip: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  Future<void> createTrip({
    required String name,
    required String description,
    required String destination,
    required DateTime startTime,
  }) async {
    setLoading(true);
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 2000));
      
      // Create route (simplified for demo)
      final route = TripRoute(
        id: 'route_${DateTime.now().millisecondsSinceEpoch}',
        name: 'Route to $destination',
        startPoint: TripWaypoint(
          id: 'start_${DateTime.now().millisecondsSinceEpoch}',
          name: 'Current Location',
          latitude: 19.0760, // Mumbai coordinates
          longitude: 72.8777,
        ),
        endPoint: TripWaypoint(
          id: 'end_${DateTime.now().millisecondsSinceEpoch}',
          name: destination,
          latitude: 15.2993, // Goa coordinates (example)
          longitude: 74.1240,
        ),
        estimatedDistance: 462.0,
        estimatedDuration: const Duration(hours: 8),
        plannedStartTime: startTime,
      );
      
      // Create trip
      final trip = Trip.create(
        name: name,
        description: description,
        leaderId: _currentUser!.id,
        route: route,
        type: TripType.leisure,
      );
      
      _activeTrip = trip;
      _loadTripData();
      
      clearError();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> startTrip() async {
    if (_activeTrip == null) return;
    
    setLoading(true);
    try {
      await Future.delayed(const Duration(milliseconds: 1000));
      
      _activeTrip = _activeTrip!.copyWith(
        status: TripStatus.active,
        startedAt: DateTime.now(),
      );
      
      // Add system message
      final systemMessage = Message.systemMessage(
        tripId: _activeTrip!.id,
        content: 'Trip started! Safe travels everyone! 🚗',
        systemData: {'type': 'trip_started'},
      );
      
      MockDataService.addMessage(systemMessage);
      _loadTripData();
      
      // Start location updates
      _isLocationUpdateEnabled = true;
      _startLocationUpdates();
      
      clearError();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> endTrip() async {
    if (_activeTrip == null) return;
    
    setLoading(true);
    try {
      await Future.delayed(const Duration(milliseconds: 1000));
      
      _activeTrip = _activeTrip!.copyWith(
        status: TripStatus.completed,
        completedAt: DateTime.now(),
      );
      
      // Stop location updates
      _isLocationUpdateEnabled = false;
      
      // Add completion message
      final systemMessage = Message.systemMessage(
        tripId: _activeTrip!.id,
        content: 'Trip completed successfully! 🎉 Hope everyone had a great time!',
        systemData: {'type': 'trip_completed'},
      );
      
      MockDataService.addMessage(systemMessage);
      _loadTripData();
      
      clearError();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  // Message management
  Future<void> sendMessage(String content, {MessageType type = MessageType.text}) async {
    if (_activeTrip == null || _currentUser == null) return;
    
    try {
      final message = Message.create(
        tripId: _activeTrip!.id,
        senderId: _currentUser!.id,
        type: type,
        content: content,
      );
      
      MockDataService.addMessage(message);
      _loadTripData();
    } catch (e) {
      setError('Failed to send message: ${e.toString()}');
    }
  }

  Future<void> sendQuickAlert(QuickAlert alert) async {
    if (_activeTrip == null || _currentUser == null) return;
    
    try {
      final message = Message.quickAlertMessage(
        tripId: _activeTrip!.id,
        senderId: _currentUser!.id,
        alert: alert,
      );
      
      MockDataService.addMessage(message);
      _loadTripData();
    } catch (e) {
      setError('Failed to send alert: ${e.toString()}');
    }
  }

  Future<void> sendEmergencyAlert(String message) async {
    if (_activeTrip == null || _currentUser == null) return;
    
    try {
      final emergencyMessage = Message.emergencyMessage(
        tripId: _activeTrip!.id,
        senderId: _currentUser!.id,
        content: message,
        emergencyData: {
          'timestamp': DateTime.now().toIso8601String(),
          'location': _getDriverLocation(),
        },
      );
      
      MockDataService.addMessage(emergencyMessage);
      _loadTripData();
      
      // Trigger emergency notifications (in real app)
      _notifyEmergencyContacts();
    } catch (e) {
      setError('Failed to send emergency alert: ${e.toString()}');
    }
  }

  Map<String, double>? _getDriverLocation() {
    // Get current user's vehicle location
    final userVehicle = _tripVehicles
        .where((v) => v.driverId == _currentUser!.id)
        .firstOrNull;
    
    if (userVehicle?.currentLocation != null) {
      return {
        'latitude': userVehicle!.currentLocation!.latitude,
        'longitude': userVehicle.currentLocation!.longitude,
      };
    }
    return null;
  }

  void _notifyEmergencyContacts() {
    // In real app, this would send push notifications/SMS to emergency contacts
    if (kDebugMode) {
      print('Emergency alert sent to emergency contacts');
    }
  }

  // Location updates
  void _startLocationUpdates() {
    // Simulate real-time location updates
    Future.doWhile(() async {
      if (!_isLocationUpdateEnabled) return false;
      
      await Future.delayed(const Duration(seconds: 5));
      MockDataService.simulateLocationUpdate();
      _loadTripData();
      
      return true;
    });
  }

  // Voice chat
  void toggleVoiceChat() {
    _isVoiceChatActive = !_isVoiceChatActive;
    notifyListeners();
  }

  // Settings
  void toggleNotifications() {
    _notificationsEnabled = !_notificationsEnabled;
    notifyListeners();
  }

  // Utility methods
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Get user by ID
  User? getUserById(String userId) {
    return MockDataService.getUserById(userId);
  }

  // Get vehicle by ID
  Vehicle? getVehicleById(String vehicleId) {
    return MockDataService.getVehicleById(vehicleId);
  }

  // Get current user's vehicle
  Vehicle? get currentUserVehicle {
    if (_currentUser?.vehicleId != null) {
      return getVehicleById(_currentUser!.vehicleId!);
    }
    return null;
  }

  // Check if current user is trip leader
  bool get isCurrentUserTripLeader {
    return _activeTrip?.isLeader(_currentUser?.id ?? '') ?? false;
  }

  // Set user type
  void setUserType(String userType) {
    _userType = userType;
    notifyListeners();
  }

  // Login method that sets current user based on user type
  Future<void> login(String email, String password, String userType) async {
    setLoading(true);
    clearError();
    
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 1500));
      
      // For demo purposes, select user based on type
      User? selectedUser;
      switch (userType) {
        case 'Driver':
          selectedUser = MockDataService.users.firstWhere(
            (user) => user.userType == UserType.driver,
            orElse: () => MockDataService.users[1], // Rohan (driver)
          );
          break;
        case 'Passenger':
          selectedUser = MockDataService.users.firstWhere(
            (user) => user.userType == UserType.passenger,
            orElse: () => MockDataService.users[2], // Aisha (passenger)
          );
          break;
        case 'Trip Leader':
          selectedUser = MockDataService.users.firstWhere(
            (user) => user.userType == UserType.leader,
            orElse: () => MockDataService.users[0], // Priya (leader)
          );
          break;
        case 'Emergency Contact':
          selectedUser = MockDataService.users.firstWhere(
            (user) => user.userType == UserType.emergencyContact,
            orElse: () => MockDataService.users[5], // Rajesh (emergency contact)
          );
          break;
        default:
          selectedUser = MockDataService.users[0]; // Default to Priya
      }
      
      // Set the current user
      _currentUser = selectedUser;
      _userType = userType;
      
      // Load active trip for this user
      _loadActiveTrip();
      
      clearError();
    } catch (e) {
      setError('Login failed: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  // Get trip statistics
  Map<String, dynamic> get tripStatistics {
    if (_activeTrip == null) return {};
    
    return {
      'totalDistance': _activeTrip!.route.estimatedDistance,
      'estimatedDuration': _activeTrip!.route.estimatedDuration,
      'progressPercentage': _activeTrip!.progressPercentage,
      'participantCount': _activeTrip!.totalParticipants,
      'vehicleCount': _activeTrip!.totalVehicles,
      'messageCount': _tripMessages.length,
      'activeVehicles': _tripVehicles.where((v) => v.isOnline).length,
    };
  }
} 