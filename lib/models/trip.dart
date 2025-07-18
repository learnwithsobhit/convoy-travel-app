enum TripStatus { planning, active, paused, completed, cancelled }

enum TripType { leisure, business, emergency, educational }

class TripWaypoint {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final String? description;
  final DateTime? plannedArrival;
  final DateTime? actualArrival;
  final Duration? estimatedStopDuration;
  final bool isRequired;
  final Map<String, dynamic> metadata;

  TripWaypoint({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.description,
    this.plannedArrival,
    this.actualArrival,
    this.estimatedStopDuration,
    this.isRequired = false,
    this.metadata = const {},
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
      'plannedArrival': plannedArrival?.toIso8601String(),
      'actualArrival': actualArrival?.toIso8601String(),
      'estimatedStopDuration': estimatedStopDuration?.inMinutes,
      'isRequired': isRequired,
      'metadata': metadata,
    };
  }

  factory TripWaypoint.fromJson(Map<String, dynamic> json) {
    return TripWaypoint(
      id: json['id'],
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      description: json['description'],
      plannedArrival: json['plannedArrival'] != null
          ? DateTime.parse(json['plannedArrival'])
          : null,
      actualArrival: json['actualArrival'] != null
          ? DateTime.parse(json['actualArrival'])
          : null,
      estimatedStopDuration: json['estimatedStopDuration'] != null
          ? Duration(minutes: json['estimatedStopDuration'])
          : null,
      isRequired: json['isRequired'] ?? false,
      metadata: Map<String, dynamic>.from(json['metadata'] ?? {}),
    );
  }
}

class TripRoute {
  final String id;
  final String name;
  final TripWaypoint startPoint;
  final TripWaypoint endPoint;
  final List<TripWaypoint> waypoints;
  final double estimatedDistance;
  final Duration estimatedDuration;
  final DateTime? plannedStartTime;
  final DateTime? actualStartTime;
  final DateTime? estimatedArrival;
  final Map<String, dynamic> routeOptions;

  TripRoute({
    required this.id,
    required this.name,
    required this.startPoint,
    required this.endPoint,
    this.waypoints = const [],
    required this.estimatedDistance,
    required this.estimatedDuration,
    this.plannedStartTime,
    this.actualStartTime,
    this.estimatedArrival,
    this.routeOptions = const {},
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'startPoint': startPoint.toJson(),
      'endPoint': endPoint.toJson(),
      'waypoints': waypoints.map((wp) => wp.toJson()).toList(),
      'estimatedDistance': estimatedDistance,
      'estimatedDuration': estimatedDuration.inMinutes,
      'plannedStartTime': plannedStartTime?.toIso8601String(),
      'actualStartTime': actualStartTime?.toIso8601String(),
      'estimatedArrival': estimatedArrival?.toIso8601String(),
      'routeOptions': routeOptions,
    };
  }

  factory TripRoute.fromJson(Map<String, dynamic> json) {
    return TripRoute(
      id: json['id'],
      name: json['name'],
      startPoint: TripWaypoint.fromJson(json['startPoint']),
      endPoint: TripWaypoint.fromJson(json['endPoint']),
      waypoints: (json['waypoints'] as List?)
              ?.map((wp) => TripWaypoint.fromJson(wp))
              .toList() ??
          [],
      estimatedDistance: json['estimatedDistance'],
      estimatedDuration: Duration(minutes: json['estimatedDuration']),
      plannedStartTime: json['plannedStartTime'] != null
          ? DateTime.parse(json['plannedStartTime'])
          : null,
      actualStartTime: json['actualStartTime'] != null
          ? DateTime.parse(json['actualStartTime'])
          : null,
      estimatedArrival: json['estimatedArrival'] != null
          ? DateTime.parse(json['estimatedArrival'])
          : null,
      routeOptions: Map<String, dynamic>.from(json['routeOptions'] ?? {}),
    );
  }
}

class Trip {
  final String id;
  final String name;
  final String description;
  final String leaderId;
  final List<String> participantIds;
  final List<String> vehicleIds;
  final TripStatus status;
  final TripType type;
  final TripRoute route;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final String joinCode;
  final Map<String, dynamic> settings;
  final List<String> emergencyContactIds;

  Trip({
    required this.id,
    required this.name,
    required this.description,
    required this.leaderId,
    required this.participantIds,
    required this.vehicleIds,
    required this.status,
    required this.type,
    required this.route,
    required this.createdAt,
    required this.updatedAt,
    this.startedAt,
    this.completedAt,
    required this.joinCode,
    this.settings = const {},
    this.emergencyContactIds = const [],
  });

  factory Trip.create({
    required String name,
    required String description,
    required String leaderId,
    required TripRoute route,
    required TripType type,
    Map<String, dynamic>? settings,
    List<String>? emergencyContactIds,
  }) {
    final now = DateTime.now();
    return Trip(
      id: 'trip_${now.millisecondsSinceEpoch}',
      name: name,
      description: description,
      leaderId: leaderId,
      participantIds: [leaderId],
      vehicleIds: [],
      status: TripStatus.planning,
      type: type,
      route: route,
      createdAt: now,
      updatedAt: now,
      joinCode: _generateJoinCode(),
      settings: settings ?? _defaultSettings(),
      emergencyContactIds: emergencyContactIds ?? [],
    );
  }

  static String _generateJoinCode() {
    final now = DateTime.now();
    return 'TRIP${now.millisecondsSinceEpoch.toString().substring(7)}';
  }

  static Map<String, dynamic> _defaultSettings() {
    return {
      'allowLateJoining': true,
      'autoUpdateRoute': true,
      'emergencyAlertsEnabled': true,
      'groupChatEnabled': true,
      'locationSharingEnabled': true,
      'voiceChatEnabled': true,
      'gamingEnabled': true,
      'maxVehicles': 10,
      'trackingAccuracy': 'high',
    };
  }

  Trip copyWith({
    String? name,
    String? description,
    String? leaderId,
    List<String>? participantIds,
    List<String>? vehicleIds,
    TripStatus? status,
    TripType? type,
    TripRoute? route,
    DateTime? startedAt,
    DateTime? completedAt,
    String? joinCode,
    Map<String, dynamic>? settings,
    List<String>? emergencyContactIds,
  }) {
    return Trip(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      leaderId: leaderId ?? this.leaderId,
      participantIds: participantIds ?? this.participantIds,
      vehicleIds: vehicleIds ?? this.vehicleIds,
      status: status ?? this.status,
      type: type ?? this.type,
      route: route ?? this.route,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      joinCode: joinCode ?? this.joinCode,
      settings: settings ?? this.settings,
      emergencyContactIds: emergencyContactIds ?? this.emergencyContactIds,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'leaderId': leaderId,
      'participantIds': participantIds,
      'vehicleIds': vehicleIds,
      'status': status.toString().split('.').last,
      'type': type.toString().split('.').last,
      'route': route.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'startedAt': startedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'joinCode': joinCode,
      'settings': settings,
      'emergencyContactIds': emergencyContactIds,
    };
  }

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      leaderId: json['leaderId'],
      participantIds: List<String>.from(json['participantIds'] ?? []),
      vehicleIds: List<String>.from(json['vehicleIds'] ?? []),
      status: TripStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      ),
      type: TripType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      route: TripRoute.fromJson(json['route']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      startedAt: json['startedAt'] != null
          ? DateTime.parse(json['startedAt'])
          : null,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : null,
      joinCode: json['joinCode'],
      settings: Map<String, dynamic>.from(json['settings'] ?? {}),
      emergencyContactIds: List<String>.from(json['emergencyContactIds'] ?? []),
    );
  }

  // Getters and utility methods
  String get statusDisplay {
    switch (status) {
      case TripStatus.planning:
        return 'Planning';
      case TripStatus.active:
        return 'Active';
      case TripStatus.paused:
        return 'Paused';
      case TripStatus.completed:
        return 'Completed';
      case TripStatus.cancelled:
        return 'Cancelled';
    }
  }

  String get typeDisplay {
    switch (type) {
      case TripType.leisure:
        return 'Leisure';
      case TripType.business:
        return 'Business';
      case TripType.emergency:
        return 'Emergency';
      case TripType.educational:
        return 'Educational';
    }
  }

  bool get isActive => status == TripStatus.active;
  bool get isCompleted => status == TripStatus.completed || status == TripStatus.cancelled;
  bool get canStart => status == TripStatus.planning && vehicleIds.isNotEmpty;
  bool get canJoin => settings['allowLateJoining'] == true || status == TripStatus.planning;

  Duration? get totalDuration {
    if (startedAt == null) return null;
    final endTime = completedAt ?? DateTime.now();
    return endTime.difference(startedAt!);
  }

  double get progressPercentage {
    if (!isActive || startedAt == null) return 0.0;
    
    final elapsed = DateTime.now().difference(startedAt!);
    final total = route.estimatedDuration;
    return (elapsed.inMinutes / total.inMinutes * 100).clamp(0.0, 100.0);
  }

  int get totalParticipants => participantIds.length;
  int get totalVehicles => vehicleIds.length;

  bool isParticipant(String userId) => participantIds.contains(userId);
  bool isLeader(String userId) => leaderId == userId;
  bool isEmergencyContact(String userId) => emergencyContactIds.contains(userId);

  Trip addParticipant(String userId) {
    if (isParticipant(userId)) return this;
    return copyWith(
      participantIds: [...participantIds, userId],
    );
  }

  Trip removeParticipant(String userId) {
    if (!isParticipant(userId) || isLeader(userId)) return this;
    return copyWith(
      participantIds: participantIds.where((id) => id != userId).toList(),
    );
  }

  Trip addVehicle(String vehicleId) {
    if (vehicleIds.contains(vehicleId)) return this;
    return copyWith(
      vehicleIds: [...vehicleIds, vehicleId],
    );
  }

  Trip removeVehicle(String vehicleId) {
    return copyWith(
      vehicleIds: vehicleIds.where((id) => id != vehicleId).toList(),
    );
  }
} 