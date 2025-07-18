enum UserType { leader, driver, passenger, emergencyContact }

enum UserStatus { online, offline, driving, inactive }

class User {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? profileImage;
  final UserType userType;
  final UserStatus status;
  final DateTime createdAt;
  final DateTime lastSeen;
  final String? vehicleId;
  final Map<String, dynamic> preferences;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.profileImage,
    required this.userType,
    this.status = UserStatus.offline,
    required this.createdAt,
    required this.lastSeen,
    this.vehicleId,
    this.preferences = const {},
  });

  factory User.create({
    required String name,
    required String email,
    String? phoneNumber,
    String? profileImage,
    required UserType userType,
    String? vehicleId,
    Map<String, dynamic>? preferences,
  }) {
    return User(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      profileImage: profileImage,
      userType: userType,
      status: UserStatus.offline,
      createdAt: DateTime.now(),
      lastSeen: DateTime.now(),
      vehicleId: vehicleId,
      preferences: preferences ?? {},
    );
  }

  User copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? profileImage,
    UserType? userType,
    UserStatus? status,
    DateTime? lastSeen,
    String? vehicleId,
    Map<String, dynamic>? preferences,
  }) {
    return User(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      userType: userType ?? this.userType,
      status: status ?? this.status,
      createdAt: createdAt,
      lastSeen: lastSeen ?? this.lastSeen,
      vehicleId: vehicleId ?? this.vehicleId,
      preferences: preferences ?? this.preferences,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'userType': userType.toString().split('.').last,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'lastSeen': lastSeen.toIso8601String(),
      'vehicleId': vehicleId,
      'preferences': preferences,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      profileImage: json['profileImage'],
      userType: UserType.values.firstWhere(
        (e) => e.toString().split('.').last == json['userType'],
      ),
      status: UserStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      ),
      createdAt: DateTime.parse(json['createdAt']),
      lastSeen: DateTime.parse(json['lastSeen']),
      vehicleId: json['vehicleId'],
      preferences: Map<String, dynamic>.from(json['preferences'] ?? {}),
    );
  }

  String get displayUserType {
    switch (userType) {
      case UserType.leader:
        return 'Trip Leader';
      case UserType.driver:
        return 'Driver';
      case UserType.passenger:
        return 'Passenger';
      case UserType.emergencyContact:
        return 'Emergency Contact';
    }
  }

  String get statusDisplay {
    switch (status) {
      case UserStatus.online:
        return 'Online';
      case UserStatus.offline:
        return 'Offline';
      case UserStatus.driving:
        return 'Driving';
      case UserStatus.inactive:
        return 'Inactive';
    }
  }

  bool get canCreateTrip => userType == UserType.leader;
  bool get canDriveVehicle => userType == UserType.leader || userType == UserType.driver;
  bool get canReceiveEmergencyAlerts => true;
} 