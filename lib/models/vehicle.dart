enum VehicleType { car, suv, motorcycle, truck, rv, van }

enum VehicleStatus { active, stopped, emergency, offline }

class VehicleLocation {
  final double latitude;
  final double longitude;
  final double? altitude;
  final double? speed;
  final double? heading;
  final double? accuracy;
  final DateTime timestamp;

  VehicleLocation({
    required this.latitude,
    required this.longitude,
    this.altitude,
    this.speed,
    this.heading,
    this.accuracy,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'altitude': altitude,
      'speed': speed,
      'heading': heading,
      'accuracy': accuracy,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory VehicleLocation.fromJson(Map<String, dynamic> json) {
    return VehicleLocation(
      latitude: json['latitude'],
      longitude: json['longitude'],
      altitude: json['altitude'],
      speed: json['speed'],
      heading: json['heading'],
      accuracy: json['accuracy'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

class Vehicle {
  final String id;
  final String name;
  final String licensePlate;
  final VehicleType type;
  final String color;
  final String? model;
  final String? make;
  final int? year;
  final String driverId;
  final List<String> passengerIds;
  final VehicleStatus status;
  final VehicleLocation? currentLocation;
  final List<VehicleLocation> locationHistory;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic> metadata;

  Vehicle({
    required this.id,
    required this.name,
    required this.licensePlate,
    required this.type,
    required this.color,
    this.model,
    this.make,
    this.year,
    required this.driverId,
    this.passengerIds = const [],
    this.status = VehicleStatus.offline,
    this.currentLocation,
    this.locationHistory = const [],
    required this.createdAt,
    required this.updatedAt,
    this.metadata = const {},
  });

  factory Vehicle.create({
    required String name,
    required String licensePlate,
    required VehicleType type,
    required String color,
    String? model,
    String? make,
    int? year,
    required String driverId,
    List<String>? passengerIds,
    Map<String, dynamic>? metadata,
  }) {
    final now = DateTime.now();
    return Vehicle(
      id: 'vehicle_${now.millisecondsSinceEpoch}',
      name: name,
      licensePlate: licensePlate,
      type: type,
      color: color,
      model: model,
      make: make,
      year: year,
      driverId: driverId,
      passengerIds: passengerIds ?? [],
      status: VehicleStatus.offline,
      createdAt: now,
      updatedAt: now,
      metadata: metadata ?? {},
    );
  }

  Vehicle copyWith({
    String? name,
    String? licensePlate,
    VehicleType? type,
    String? color,
    String? model,
    String? make,
    int? year,
    String? driverId,
    List<String>? passengerIds,
    VehicleStatus? status,
    VehicleLocation? currentLocation,
    List<VehicleLocation>? locationHistory,
    Map<String, dynamic>? metadata,
  }) {
    return Vehicle(
      id: id,
      name: name ?? this.name,
      licensePlate: licensePlate ?? this.licensePlate,
      type: type ?? this.type,
      color: color ?? this.color,
      model: model ?? this.model,
      make: make ?? this.make,
      year: year ?? this.year,
      driverId: driverId ?? this.driverId,
      passengerIds: passengerIds ?? this.passengerIds,
      status: status ?? this.status,
      currentLocation: currentLocation ?? this.currentLocation,
      locationHistory: locationHistory ?? this.locationHistory,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      metadata: metadata ?? this.metadata,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'licensePlate': licensePlate,
      'type': type.toString().split('.').last,
      'color': color,
      'model': model,
      'make': make,
      'year': year,
      'driverId': driverId,
      'passengerIds': passengerIds,
      'status': status.toString().split('.').last,
      'currentLocation': currentLocation?.toJson(),
      'locationHistory': locationHistory.map((loc) => loc.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'metadata': metadata,
    };
  }

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      name: json['name'],
      licensePlate: json['licensePlate'],
      type: VehicleType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      color: json['color'],
      model: json['model'],
      make: json['make'],
      year: json['year'],
      driverId: json['driverId'],
      passengerIds: List<String>.from(json['passengerIds'] ?? []),
      status: VehicleStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      ),
      currentLocation: json['currentLocation'] != null
          ? VehicleLocation.fromJson(json['currentLocation'])
          : null,
      locationHistory: (json['locationHistory'] as List?)
              ?.map((loc) => VehicleLocation.fromJson(loc))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      metadata: Map<String, dynamic>.from(json['metadata'] ?? {}),
    );
  }

  String get displayType {
    switch (type) {
      case VehicleType.car:
        return 'Car';
      case VehicleType.suv:
        return 'SUV';
      case VehicleType.motorcycle:
        return 'Motorcycle';
      case VehicleType.truck:
        return 'Truck';
      case VehicleType.rv:
        return 'RV';
      case VehicleType.van:
        return 'Van';
    }
  }

  String get statusDisplay {
    switch (status) {
      case VehicleStatus.active:
        return 'Active';
      case VehicleStatus.stopped:
        return 'Stopped';
      case VehicleStatus.emergency:
        return 'Emergency';
      case VehicleStatus.offline:
        return 'Offline';
    }
  }

  String get fullDescription {
    final parts = <String>[];
    if (year != null) parts.add(year.toString());
    if (make != null) parts.add(make!);
    if (model != null) parts.add(model!);
    if (parts.isEmpty) parts.add(displayType);
    return parts.join(' ');
  }

  bool get isOnline => status != VehicleStatus.offline;
  bool get isEmergency => status == VehicleStatus.emergency;
  bool get isMoving => currentLocation?.speed != null && currentLocation!.speed! > 0;

  int get occupantCount => passengerIds.length + 1; // +1 for driver

  double? distanceFromLocation(double lat, double lng) {
    if (currentLocation == null) return null;
    
    // Simplified distance calculation (Haversine formula would be more accurate)
    final latDiff = currentLocation!.latitude - lat;
    final lngDiff = currentLocation!.longitude - lng;
    return (latDiff * latDiff + lngDiff * lngDiff) * 111000; // Rough conversion to meters
  }
} 