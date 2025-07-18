import '../models/index.dart';

class MockDataService {
  static final List<User> _users = [];
  static final List<Vehicle> _vehicles = [];
  static final List<Trip> _trips = [];
  static final List<Message> _messages = [];

  // Initialize mock data
  static void initialize() {
    if (_users.isNotEmpty) return; // Already initialized

    _initializeUsers();
    _initializeVehicles();
    _initializeTrips();
    _initializeMessages();
  }

  static void _initializeUsers() {
    final now = DateTime.now();

    _users.addAll([
      // Trip Leader: Priya
      User(
        id: 'user_1',
        name: 'Priya Sharma',
        email: 'priya@example.com',
        phoneNumber: '+91 98765 43210',
        profileImage: 'https://example.com/avatars/priya.jpg',
        userType: UserType.leader,
        status: UserStatus.driving,
        createdAt: now.subtract(const Duration(days: 30)),
        lastSeen: now.subtract(const Duration(minutes: 2)),
        vehicleId: 'vehicle_1',
        preferences: {
          'notificationsEnabled': true,
          'voiceChatEnabled': true,
          'locationSharingEnabled': true,
          'preferredBreakInterval': 120, // minutes
        },
      ),

      // Driver: Rohan
      User(
        id: 'user_2',
        name: 'Rohan Kumar',
        email: 'rohan@example.com',
        phoneNumber: '+91 98765 43211',
        profileImage: 'https://example.com/avatars/rohan.jpg',
        userType: UserType.driver,
        status: UserStatus.driving,
        createdAt: now.subtract(const Duration(days: 20)),
        lastSeen: now.subtract(const Duration(minutes: 1)),
        vehicleId: 'vehicle_2',
        preferences: {
          'notificationsEnabled': true,
          'voiceChatEnabled': true,
          'musicGenre': 'rock',
        },
      ),

      // Passenger: Aisha
      User(
        id: 'user_3',
        name: 'Aisha Patel',
        email: 'aisha@example.com',
        phoneNumber: '+91 98765 43212',
        profileImage: 'https://example.com/avatars/aisha.jpg',
        userType: UserType.passenger,
        status: UserStatus.online,
        createdAt: now.subtract(const Duration(days: 15)),
        lastSeen: now,
        vehicleId: 'vehicle_1',
        preferences: {
          'notificationsEnabled': true,
          'gamesEnabled': true,
          'photoSharingEnabled': true,
        },
      ),

      // Driver: Vikram
      User(
        id: 'user_4',
        name: 'Vikram Singh',
        email: 'vikram@example.com',
        phoneNumber: '+91 98765 43213',
        userType: UserType.driver,
        status: UserStatus.driving,
        createdAt: now.subtract(const Duration(days: 25)),
        lastSeen: now.subtract(const Duration(minutes: 3)),
        vehicleId: 'vehicle_3',
        preferences: {
          'notificationsEnabled': true,
          'voiceChatEnabled': true,
        },
      ),

      // Passenger: Maya
      User(
        id: 'user_5',
        name: 'Maya Reddy',
        email: 'maya@example.com',
        phoneNumber: '+91 98765 43214',
        userType: UserType.passenger,
        status: UserStatus.online,
        createdAt: now.subtract(const Duration(days: 10)),
        lastSeen: now.subtract(const Duration(minutes: 5)),
        vehicleId: 'vehicle_2',
        preferences: {
          'notificationsEnabled': true,
          'gamesEnabled': true,
        },
      ),

      // Emergency Contact: Mr. Sharma
      User(
        id: 'user_6',
        name: 'Rajesh Sharma',
        email: 'rajesh@example.com',
        phoneNumber: '+91 98765 43215',
        userType: UserType.emergencyContact,
        status: UserStatus.online,
        createdAt: now.subtract(const Duration(days: 365)),
        lastSeen: now.subtract(const Duration(hours: 2)),
        preferences: {
          'emergencyAlertsEnabled': true,
          'statusUpdatesEnabled': true,
        },
      ),

      // Additional passengers
      User(
        id: 'user_7',
        name: 'Ankit Gupta',
        email: 'ankit@example.com',
        userType: UserType.passenger,
        status: UserStatus.online,
        createdAt: now.subtract(const Duration(days: 12)),
        lastSeen: now.subtract(const Duration(minutes: 1)),
        vehicleId: 'vehicle_3',
      ),

      User(
        id: 'user_8',
        name: 'Sneha Joshi',
        email: 'sneha@example.com',
        userType: UserType.passenger,
        status: UserStatus.online,
        createdAt: now.subtract(const Duration(days: 8)),
        lastSeen: now.subtract(const Duration(minutes: 4)),
        vehicleId: 'vehicle_1',
      ),
    ]);
  }

  static void _initializeVehicles() {
    final now = DateTime.now();

    _vehicles.addAll([
      // Priya's car
      Vehicle(
        id: 'vehicle_1',
        name: 'Blue Thunder',
        licensePlate: 'MH 12 AB 1234',
        type: VehicleType.suv,
        color: 'Blue',
        model: 'Creta',
        make: 'Hyundai',
        year: 2022,
        driverId: 'user_1',
        passengerIds: ['user_3', 'user_8'],
        status: VehicleStatus.active,
        currentLocation: VehicleLocation(
          latitude: 19.0760,
          longitude: 72.8777,
          speed: 65.0,
          heading: 45.0,
          timestamp: now.subtract(const Duration(seconds: 30)),
        ),
        createdAt: now.subtract(const Duration(days: 30)),
        updatedAt: now.subtract(const Duration(seconds: 30)),
        metadata: {
          'fuelCapacity': 50,
          'currentFuel': 35,
          'seatingCapacity': 5,
        },
      ),

      // Rohan's car
      Vehicle(
        id: 'vehicle_2',
        name: 'Red Rocket',
        licensePlate: 'KA 05 CD 5678',
        type: VehicleType.car,
        color: 'Red',
        model: 'City',
        make: 'Honda',
        year: 2021,
        driverId: 'user_2',
        passengerIds: ['user_5'],
        status: VehicleStatus.active,
        currentLocation: VehicleLocation(
          latitude: 19.0720,
          longitude: 72.8740,
          speed: 62.0,
          heading: 42.0,
          timestamp: now.subtract(const Duration(seconds: 45)),
        ),
        createdAt: now.subtract(const Duration(days: 20)),
        updatedAt: now.subtract(const Duration(seconds: 45)),
        metadata: {
          'fuelCapacity': 40,
          'currentFuel': 28,
          'seatingCapacity': 4,
        },
      ),

      // Vikram's SUV
      Vehicle(
        id: 'vehicle_3',
        name: 'Black Beast',
        licensePlate: 'DL 08 EF 9012',
        type: VehicleType.suv,
        color: 'Black',
        model: 'Fortuner',
        make: 'Toyota',
        year: 2023,
        driverId: 'user_4',
        passengerIds: ['user_7'],
        status: VehicleStatus.active,
        currentLocation: VehicleLocation(
          latitude: 19.0690,
          longitude: 72.8800,
          speed: 68.0,
          heading: 48.0,
          timestamp: now.subtract(const Duration(seconds: 60)),
        ),
        createdAt: now.subtract(const Duration(days: 25)),
        updatedAt: now.subtract(const Duration(seconds: 60)),
        metadata: {
          'fuelCapacity': 80,
          'currentFuel': 55,
          'seatingCapacity': 7,
        },
      ),
    ]);
  }

  static void _initializeTrips() {
    final now = DateTime.now();
    
    // Create waypoints for the route
    final startPoint = TripWaypoint(
      id: 'wp_start',
      name: 'Mumbai Central',
      latitude: 19.0760,
      longitude: 72.8777,
      description: 'Starting point - Mumbai Central Station',
      plannedArrival: now.subtract(const Duration(hours: 2)),
      actualArrival: now.subtract(const Duration(hours: 2)),
      isRequired: true,
    );

    final waypoint1 = TripWaypoint(
      id: 'wp_1',
      name: 'Lonavala',
      latitude: 18.7537,
      longitude: 73.4068,
      description: 'Rest stop at Lonavala for breakfast',
      plannedArrival: now.add(const Duration(hours: 1)),
      estimatedStopDuration: const Duration(minutes: 30),
      isRequired: true,
    );

    final waypoint2 = TripWaypoint(
      id: 'wp_2',
      name: 'Pune Bypass',
      latitude: 18.5679,
      longitude: 73.9143,
      description: 'Quick fuel stop',
      plannedArrival: now.add(const Duration(hours: 3)),
      estimatedStopDuration: const Duration(minutes: 15),
      isRequired: false,
    );

    final endPoint = TripWaypoint(
      id: 'wp_end',
      name: 'Goa Beach Resort',
      latitude: 15.2993,
      longitude: 74.1240,
      description: 'Final destination - Beach Resort in Goa',
      plannedArrival: now.add(const Duration(hours: 8)),
      isRequired: true,
    );

    final route = TripRoute(
      id: 'route_1',
      name: 'Mumbai to Goa Coastal Highway',
      startPoint: startPoint,
      endPoint: endPoint,
      waypoints: [waypoint1, waypoint2],
      estimatedDistance: 462.0, // km
      estimatedDuration: const Duration(hours: 8),
      plannedStartTime: now.subtract(const Duration(hours: 2)),
      actualStartTime: now.subtract(const Duration(hours: 2)),
      estimatedArrival: now.add(const Duration(hours: 6)),
      routeOptions: {
        'avoidTolls': false,
        'avoidHighways': false,
        'preferScenicRoute': true,
      },
    );

    final activeTrip = Trip(
      id: 'trip_1',
      name: 'Mumbai to Goa Weekend Trip',
      description: 'A fun weekend trip to Goa with friends. Beach time, good food, and great memories!',
      leaderId: 'user_1',
      participantIds: ['user_1', 'user_2', 'user_3', 'user_4', 'user_5', 'user_7', 'user_8'],
      vehicleIds: ['vehicle_1', 'vehicle_2', 'vehicle_3'],
      status: TripStatus.active,
      type: TripType.leisure,
      route: route,
      createdAt: now.subtract(const Duration(days: 7)),
      updatedAt: now.subtract(const Duration(minutes: 5)),
      startedAt: now.subtract(const Duration(hours: 2)),
      joinCode: 'TRIP12345',
      emergencyContactIds: ['user_6'],
      settings: {
        'allowLateJoining': true,
        'autoUpdateRoute': true,
        'emergencyAlertsEnabled': true,
        'groupChatEnabled': true,
        'locationSharingEnabled': true,
        'voiceChatEnabled': true,
        'gamingEnabled': true,
        'maxVehicles': 5,
        'trackingAccuracy': 'high',
      },
    );

    _trips.add(activeTrip);

    // Add a completed trip for history
    final completedRoute = TripRoute(
      id: 'route_2',
      name: 'Mumbai to Lonavala Day Trip',
      startPoint: TripWaypoint(
        id: 'wp_start_2',
        name: 'Mumbai',
        latitude: 19.0760,
        longitude: 72.8777,
      ),
      endPoint: TripWaypoint(
        id: 'wp_end_2',
        name: 'Lonavala',
        latitude: 18.7537,
        longitude: 73.4068,
      ),
      estimatedDistance: 83.0,
      estimatedDuration: const Duration(hours: 2),
    );

    final completedTrip = Trip(
      id: 'trip_2',
      name: 'Lonavala Day Trip',
      description: 'Quick day trip to Lonavala hills',
      leaderId: 'user_1',
      participantIds: ['user_1', 'user_2', 'user_3'],
      vehicleIds: ['vehicle_1'],
      status: TripStatus.completed,
      type: TripType.leisure,
      route: completedRoute,
      createdAt: now.subtract(const Duration(days: 15)),
      updatedAt: now.subtract(const Duration(days: 14)),
      startedAt: now.subtract(const Duration(days: 14, hours: 8)),
      completedAt: now.subtract(const Duration(days: 14)),
      joinCode: 'TRIP67890',
    );

    _trips.add(completedTrip);

    // Add more joinable trips for demo
    
    // Delhi to Rishikesh Adventure Trip (Starting Soon)
    final rishikeshRoute = TripRoute(
      id: 'route_3',
      name: 'Delhi to Rishikesh Adventure Route',
      startPoint: TripWaypoint(
        id: 'wp_delhi',
        name: 'India Gate, Delhi',
        latitude: 28.6129,
        longitude: 77.2295,
      ),
      endPoint: TripWaypoint(
        id: 'wp_rishikesh',
        name: 'Rishikesh, Uttarakhand',
        latitude: 30.0869,
        longitude: 78.2676,
      ),
      estimatedDistance: 238.0,
      estimatedDuration: const Duration(hours: 5),
      plannedStartTime: now.add(const Duration(hours: 2)),
    );

    final rishikeshTrip = Trip(
      id: 'trip_3',
      name: 'Delhi to Rishikesh Adventure',
      description: 'River rafting and mountain adventure in Rishikesh! Join us for an adrenaline-filled weekend.',
      leaderId: 'user_2',
      participantIds: ['user_2', 'user_4'],
      vehicleIds: ['vehicle_2'],
      status: TripStatus.planning,
      type: TripType.leisure,
      route: rishikeshRoute,
      createdAt: now.subtract(const Duration(days: 3)),
      updatedAt: now.subtract(const Duration(hours: 1)),
      joinCode: 'RIVER2024',
      settings: {
        'allowLateJoining': true,
        'maxVehicles': 3,
        'groupChatEnabled': true,
        'emergencyAlertsEnabled': true,
      },
    );

    _trips.add(rishikeshTrip);

    // Bangalore to Coorg Coffee Trip (Active)
    final coorgRoute = TripRoute(
      id: 'route_4',
      name: 'Bangalore to Coorg Coffee Estates',
      startPoint: TripWaypoint(
        id: 'wp_bangalore',
        name: 'Bangalore City Center',
        latitude: 12.9716,
        longitude: 77.5946,
      ),
      endPoint: TripWaypoint(
        id: 'wp_coorg',
        name: 'Coorg Coffee Estates',
        latitude: 12.3375,
        longitude: 75.8069,
      ),
      estimatedDistance: 252.0,
      estimatedDuration: const Duration(hours: 6),
      plannedStartTime: now.subtract(const Duration(minutes: 30)),
      actualStartTime: now.subtract(const Duration(minutes: 30)),
    );

    final coorgTrip = Trip(
      id: 'trip_4',
      name: 'Bangalore to Coorg Coffee Trail',
      description: 'Aromatic coffee plantations and scenic hill views. Perfect for coffee lovers!',
      leaderId: 'user_5',
      participantIds: ['user_5', 'user_6'],
      vehicleIds: ['vehicle_1'],
      status: TripStatus.active,
      type: TripType.leisure,
      route: coorgRoute,
      createdAt: now.subtract(const Duration(days: 2)),
      updatedAt: now.subtract(const Duration(minutes: 10)),
      startedAt: now.subtract(const Duration(minutes: 30)),
      joinCode: 'COFFEE123',
      settings: {
        'allowLateJoining': true,
        'maxVehicles': 2,
        'groupChatEnabled': true,
      },
    );

    _trips.add(coorgTrip);

    // Chennai to Pondicherry Beach Trip (Planning Stage)
    final pondyRoute = TripRoute(
      id: 'route_5',
      name: 'Chennai to Pondicherry Coastal Drive',
      startPoint: TripWaypoint(
        id: 'wp_chennai',
        name: 'Marina Beach, Chennai',
        latitude: 13.0477,
        longitude: 80.2824,
      ),
      endPoint: TripWaypoint(
        id: 'wp_pondy',
        name: 'Promenade Beach, Pondicherry',
        latitude: 11.9416,
        longitude: 79.8083,
      ),
      estimatedDistance: 162.0,
      estimatedDuration: const Duration(hours: 3),
      plannedStartTime: now.add(const Duration(days: 1)),
    );

    final pondyTrip = Trip(
      id: 'trip_5',
      name: 'Chennai to Pondicherry Beach Vibes',
      description: 'French colonial charm meets beautiful beaches. A perfect day trip for beach lovers!',
      leaderId: 'user_7',
      participantIds: ['user_7'],
      vehicleIds: [],
      status: TripStatus.planning,
      type: TripType.leisure,
      route: pondyRoute,
      createdAt: now.subtract(const Duration(hours: 6)),
      updatedAt: now.subtract(const Duration(hours: 2)),
      joinCode: 'BEACH789',
      settings: {
        'allowLateJoining': true,
        'maxVehicles': 4,
        'groupChatEnabled': true,
        'locationSharingEnabled': true,
      },
    );

    _trips.add(pondyTrip);

    // Jaipur to Udaipur Royal Trip (Weekend Plan)
    final udaipurRoute = TripRoute(
      id: 'route_6',
      name: 'Jaipur to Udaipur Royal Heritage Route',
      startPoint: TripWaypoint(
        id: 'wp_jaipur',
        name: 'Hawa Mahal, Jaipur',
        latitude: 26.9124,
        longitude: 75.8267,
      ),
      endPoint: TripWaypoint(
        id: 'wp_udaipur',
        name: 'City Palace, Udaipur',
        latitude: 24.5854,
        longitude: 73.6830,
      ),
      estimatedDistance: 393.0,
      estimatedDuration: const Duration(hours: 6),
      plannedStartTime: now.add(const Duration(days: 2, hours: 6)),
    );

    final udaipurTrip = Trip(
      id: 'trip_6',
      name: 'Jaipur to Udaipur Royal Heritage',
      description: 'Experience the royal heritage of Rajasthan! Visit magnificent palaces and lakes.',
      leaderId: 'user_8',
      participantIds: ['user_8'],
      vehicleIds: [],
      status: TripStatus.planning,
      type: TripType.educational,
      route: udaipurRoute,
      createdAt: now.subtract(const Duration(hours: 12)),
      updatedAt: now.subtract(const Duration(hours: 4)),
      joinCode: 'ROYAL456',
      settings: {
        'allowLateJoining': true,
        'maxVehicles': 3,
        'groupChatEnabled': true,
        'emergencyAlertsEnabled': true,
        'culturalEnabled': true,
      },
    );

    _trips.add(udaipurTrip);
  }

  static void _initializeMessages() {
    final now = DateTime.now();
    
    // Create messages with proper timestamps and status
    final messages = <Message>[
      // Welcome system message
      Message(
        id: 'msg_system_1',
        tripId: 'trip_1',
        senderId: 'system',
        type: MessageType.system,
        content: 'Welcome to Mumbai to Goa Weekend Trip! 🎉 Trip started successfully.',
        priority: MessagePriority.normal,
        status: MessageStatus.read,
        createdAt: now.subtract(const Duration(hours: 2)),
        readByUserIds: ['user_1', 'user_2', 'user_3', 'user_4', 'user_5', 'user_7', 'user_8'],
        metadata: {'type': 'trip_started'},
      ),

      // Group messages
      Message(
        id: 'msg_1',
        tripId: 'trip_1',
        senderId: 'user_1',
        type: MessageType.text,
        content: 'Hey everyone! Ready for an amazing trip to Goa? 🏖️',
        status: MessageStatus.read,
        createdAt: now.subtract(const Duration(hours: 1, minutes: 45)),
        readByUserIds: ['user_2', 'user_3', 'user_4', 'user_5', 'user_7', 'user_8'],
      ),

      Message(
        id: 'msg_2',
        tripId: 'trip_1',
        senderId: 'user_3',
        type: MessageType.text,
        content: 'So excited! 🎊 Can\'t wait to reach the beach!',
        status: MessageStatus.read,
        createdAt: now.subtract(const Duration(hours: 1, minutes: 40)),
        readByUserIds: ['user_1', 'user_2', 'user_4', 'user_5', 'user_7', 'user_8'],
      ),

      // Quick alert messages
      Message(
        id: 'msg_3',
        tripId: 'trip_1',
        senderId: 'user_2',
        type: MessageType.quickAlert,
        content: 'Police ahead!',
        priority: MessagePriority.normal,
        status: MessageStatus.read,
        createdAt: now.subtract(const Duration(minutes: 30)),
        readByUserIds: ['user_1', 'user_3', 'user_4', 'user_5', 'user_7', 'user_8'],
        quickAlert: QuickAlert.predefined['cops_ahead'],
      ),

      Message(
        id: 'msg_4',
        tripId: 'trip_1',
        senderId: 'user_4',
        type: MessageType.text,
        content: 'Thanks for the heads up! Slowing down now.',
        status: MessageStatus.read,
        createdAt: now.subtract(const Duration(minutes: 28)),
        readByUserIds: ['user_1', 'user_2', 'user_3', 'user_5', 'user_7', 'user_8'],
        replyToMessageId: 'msg_3',
      ),

      Message(
        id: 'msg_5',
        tripId: 'trip_1',
        senderId: 'user_5',
        type: MessageType.quickAlert,
        content: 'Food/rest break needed',
        priority: MessagePriority.normal,
        status: MessageStatus.read,
        createdAt: now.subtract(const Duration(minutes: 15)),
        readByUserIds: ['user_1', 'user_2', 'user_3', 'user_4', 'user_7', 'user_8'],
        quickAlert: QuickAlert.predefined['food_break'],
      ),

      Message(
        id: 'msg_6',
        tripId: 'trip_1',
        senderId: 'user_1',
        type: MessageType.text,
        content: 'Great idea! Let\'s stop at the next dhaba. I\'m hungry too! 🍽️',
        status: MessageStatus.read,
        createdAt: now.subtract(const Duration(minutes: 13)),
        readByUserIds: ['user_2', 'user_3', 'user_4', 'user_5', 'user_7', 'user_8'],
      ),

      Message(
        id: 'msg_7',
        tripId: 'trip_1',
        senderId: 'user_7',
        type: MessageType.text,
        content: 'I see a good restaurant coming up in 2 km. Should we stop there?',
        status: MessageStatus.read,
        createdAt: now.subtract(const Duration(minutes: 10)),
        readByUserIds: ['user_1', 'user_2', 'user_3', 'user_4', 'user_5', 'user_8'],
      ),

      Message(
        id: 'msg_8',
        tripId: 'trip_1',
        senderId: 'user_1',
        type: MessageType.announcement,
        content: '📢 All vehicles: Taking exit at next restaurant. Follow my lead!',
        priority: MessagePriority.high,
        status: MessageStatus.read,
        createdAt: now.subtract(const Duration(minutes: 8)),
        readByUserIds: ['user_2', 'user_3', 'user_4', 'user_5', 'user_7', 'user_8'],
      ),

      Message(
        id: 'msg_9',
        tripId: 'trip_1',
        senderId: 'user_8',
        type: MessageType.text,
        content: 'Perfect! I was just thinking about some hot chai ☕',
        status: MessageStatus.read,
        createdAt: now.subtract(const Duration(minutes: 6)),
        readByUserIds: ['user_1', 'user_2', 'user_3', 'user_4', 'user_5', 'user_7'],
      ),

      Message(
        id: 'msg_10',
        tripId: 'trip_1',
        senderId: 'user_3',
        type: MessageType.text,
        content: 'Who wants to play a road trip game while we\'re stopped? 🎮',
        status: MessageStatus.read,
        createdAt: now.subtract(const Duration(minutes: 4)),
        readByUserIds: ['user_1', 'user_2', 'user_4', 'user_5', 'user_7', 'user_8'],
      ),

      Message(
        id: 'msg_11',
        tripId: 'trip_1',
        senderId: 'user_2',
        type: MessageType.text,
        content: 'I\'m in! What game should we play?',
        status: MessageStatus.read,
        createdAt: now.subtract(const Duration(minutes: 3)),
        readByUserIds: ['user_1', 'user_3', 'user_4', 'user_5', 'user_7', 'user_8'],
      ),

      Message(
        id: 'msg_12',
        tripId: 'trip_1',
        senderId: 'user_4',
        type: MessageType.text,
        content: 'Currently at the restaurant. Food looks amazing! 😋',
        status: MessageStatus.delivered,
        createdAt: now.subtract(const Duration(minutes: 1)),
        readByUserIds: ['user_1', 'user_2', 'user_3'],
      ),
    ];

    _messages.addAll(messages);
  }

  // Getter methods
  static List<User> get users => List.unmodifiable(_users);
  static List<Vehicle> get vehicles => List.unmodifiable(_vehicles);
  static List<Trip> get trips => List.unmodifiable(_trips);
  static List<Message> get messages => List.unmodifiable(_messages);

  // Helper methods to get specific data
  static User? getUserById(String id) {
    try {
      return _users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }

  static Vehicle? getVehicleById(String id) {
    try {
      return _vehicles.firstWhere((vehicle) => vehicle.id == id);
    } catch (e) {
      return null;
    }
  }

  static Trip? getTripById(String id) {
    try {
      return _trips.firstWhere((trip) => trip.id == id);
    } catch (e) {
      return null;
    }
  }

  static Trip? getActiveTripForUser(String userId) {
    try {
      // Find trips that are either active or in planning phase
      return _trips.firstWhere(
        (trip) => trip.isParticipant(userId) && 
                  (trip.status == TripStatus.active || trip.status == TripStatus.planning),
      );
    } catch (e) {
      return null;
    }
  }

  static List<Message> getMessagesForTrip(String tripId) {
    return _messages.where((message) => message.tripId == tripId).toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  static List<User> getUsersForTrip(String tripId) {
    final trip = getTripById(tripId);
    if (trip == null) return [];
    
    return _users.where((user) => trip.isParticipant(user.id)).toList();
  }

  static List<Vehicle> getVehiclesForTrip(String tripId) {
    final trip = getTripById(tripId);
    if (trip == null) return [];
    
    return _vehicles.where((vehicle) => trip.vehicleIds.contains(vehicle.id)).toList();
  }

  // Simulate real-time updates
  static void simulateLocationUpdate() {
    for (var i = 0; i < _vehicles.length; i++) {
      final vehicle = _vehicles[i];
      if (vehicle.status == VehicleStatus.active && vehicle.currentLocation != null) {
        final currentLat = vehicle.currentLocation!.latitude;
        final currentLng = vehicle.currentLocation!.longitude;
        
        // Simulate movement along the route (very simplified)
        final newLat = currentLat + (0.001 * (i + 1)); // Small increment
        final newLng = currentLng + (0.001 * (i + 1));
        
        final newLocation = VehicleLocation(
          latitude: newLat,
          longitude: newLng,
          speed: vehicle.currentLocation!.speed! + (i - 1) * 2,
          heading: vehicle.currentLocation!.heading,
          timestamp: DateTime.now(),
        );

        _vehicles[i] = vehicle.copyWith(
          currentLocation: newLocation,
          locationHistory: [...vehicle.locationHistory, newLocation],
        );
      }
    }
  }

  // Add new message (for demo purposes)
  static void addMessage(Message message) {
    _messages.add(message);
  }

  // Current user (for demo - in real app this would come from auth)
  static User get currentUser => _users.first; // Priya as current user
} 