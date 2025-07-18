enum MessageType {
  text,
  voice,
  image,
  location,
  emergency,
  system,
  quickAlert,
  gameInvite,
  announcement
}

enum MessagePriority { low, normal, high, emergency }

enum MessageStatus { sending, sent, delivered, read, failed }

class MessageAttachment {
  final String id;
  final String type; // 'image', 'voice', 'location', 'file'
  final String url;
  final String? fileName;
  final int? fileSize;
  final Map<String, dynamic> metadata;

  MessageAttachment({
    required this.id,
    required this.type,
    required this.url,
    this.fileName,
    this.fileSize,
    this.metadata = const {},
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'url': url,
      'fileName': fileName,
      'fileSize': fileSize,
      'metadata': metadata,
    };
  }

  factory MessageAttachment.fromJson(Map<String, dynamic> json) {
    return MessageAttachment(
      id: json['id'],
      type: json['type'],
      url: json['url'],
      fileName: json['fileName'],
      fileSize: json['fileSize'],
      metadata: Map<String, dynamic>.from(json['metadata'] ?? {}),
    );
  }
}

class QuickAlert {
  final String type;
  final String message;
  final String? icon;
  final Map<String, dynamic> data;

  QuickAlert({
    required this.type,
    required this.message,
    this.icon,
    this.data = const {},
  });

  static final Map<String, QuickAlert> predefined = {
    'cops_ahead': QuickAlert(
      type: 'cops_ahead',
      message: 'Police ahead!',
      icon: '🚔',
      data: {'severity': 'warning'},
    ),
    'gas_needed': QuickAlert(
      type: 'gas_needed',
      message: 'Need gas stop',
      icon: '⛽',
      data: {'severity': 'info'},
    ),
    'food_break': QuickAlert(
      type: 'food_break',
      message: 'Food/rest break needed',
      icon: '🍔',
      data: {'severity': 'info'},
    ),
    'bathroom_break': QuickAlert(
      type: 'bathroom_break',
      message: 'Bathroom break needed',
      icon: '🚻',
      data: {'severity': 'info'},
    ),
    'vehicle_trouble': QuickAlert(
      type: 'vehicle_trouble',
      message: 'Vehicle trouble!',
      icon: '🔧',
      data: {'severity': 'high'},
    ),
    'wrong_turn': QuickAlert(
      type: 'wrong_turn',
      message: 'Took wrong turn',
      icon: '↩️',
      data: {'severity': 'warning'},
    ),
    'slow_down': QuickAlert(
      type: 'slow_down',
      message: 'Slow down',
      icon: '🐌',
      data: {'severity': 'warning'},
    ),
    'speed_up': QuickAlert(
      type: 'speed_up',
      message: 'Speed up',
      icon: '⚡',
      data: {'severity': 'info'},
    ),
  };

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'message': message,
      'icon': icon,
      'data': data,
    };
  }

  factory QuickAlert.fromJson(Map<String, dynamic> json) {
    return QuickAlert(
      type: json['type'],
      message: json['message'],
      icon: json['icon'],
      data: Map<String, dynamic>.from(json['data'] ?? {}),
    );
  }
}

class Message {
  final String id;
  final String tripId;
  final String senderId;
  final String? recipientId; // null for group messages
  final MessageType type;
  final String content;
  final MessagePriority priority;
  final MessageStatus status;
  final DateTime createdAt;
  final DateTime? deliveredAt;
  final DateTime? readAt;
  final List<MessageAttachment> attachments;
  final QuickAlert? quickAlert;
  final Map<String, dynamic> metadata;
  final String? replyToMessageId;
  final List<String> readByUserIds;

  Message({
    required this.id,
    required this.tripId,
    required this.senderId,
    this.recipientId,
    required this.type,
    required this.content,
    this.priority = MessagePriority.normal,
    this.status = MessageStatus.sending,
    required this.createdAt,
    this.deliveredAt,
    this.readAt,
    this.attachments = const [],
    this.quickAlert,
    this.metadata = const {},
    this.replyToMessageId,
    this.readByUserIds = const [],
  });

  factory Message.create({
    required String tripId,
    required String senderId,
    String? recipientId,
    required MessageType type,
    required String content,
    MessagePriority? priority,
    List<MessageAttachment>? attachments,
    QuickAlert? quickAlert,
    Map<String, dynamic>? metadata,
    String? replyToMessageId,
  }) {
    final now = DateTime.now();
    return Message(
      id: 'msg_${now.millisecondsSinceEpoch}',
      tripId: tripId,
      senderId: senderId,
      recipientId: recipientId,
      type: type,
      content: content,
      priority: priority ?? MessagePriority.normal,
      status: MessageStatus.sending,
      createdAt: now,
      attachments: attachments ?? [],
      quickAlert: quickAlert,
      metadata: metadata ?? {},
      replyToMessageId: replyToMessageId,
      readByUserIds: [],
    );
  }

  // Factory methods for specific message types
  factory Message.textMessage({
    required String tripId,
    required String senderId,
    required String content,
    String? recipientId,
    String? replyToMessageId,
  }) {
    return Message.create(
      tripId: tripId,
      senderId: senderId,
      recipientId: recipientId,
      type: MessageType.text,
      content: content,
      replyToMessageId: replyToMessageId,
    );
  }

  factory Message.quickAlertMessage({
    required String tripId,
    required String senderId,
    required QuickAlert alert,
  }) {
    return Message.create(
      tripId: tripId,
      senderId: senderId,
      type: MessageType.quickAlert,
      content: alert.message,
      priority: alert.data['severity'] == 'emergency'
          ? MessagePriority.emergency
          : alert.data['severity'] == 'high'
              ? MessagePriority.high
              : MessagePriority.normal,
      quickAlert: alert,
    );
  }

  factory Message.emergencyMessage({
    required String tripId,
    required String senderId,
    required String content,
    Map<String, dynamic>? emergencyData,
  }) {
    return Message.create(
      tripId: tripId,
      senderId: senderId,
      type: MessageType.emergency,
      content: content,
      priority: MessagePriority.emergency,
      metadata: emergencyData ?? {},
    );
  }

  factory Message.systemMessage({
    required String tripId,
    required String content,
    Map<String, dynamic>? systemData,
  }) {
    return Message.create(
      tripId: tripId,
      senderId: 'system',
      type: MessageType.system,
      content: content,
      priority: MessagePriority.normal,
      metadata: systemData ?? {},
    );
  }

  factory Message.announcementMessage({
    required String tripId,
    required String senderId,
    required String content,
  }) {
    return Message.create(
      tripId: tripId,
      senderId: senderId,
      type: MessageType.announcement,
      content: content,
      priority: MessagePriority.high,
    );
  }

  Message copyWith({
    MessageStatus? status,
    DateTime? deliveredAt,
    DateTime? readAt,
    List<MessageAttachment>? attachments,
    Map<String, dynamic>? metadata,
    List<String>? readByUserIds,
  }) {
    return Message(
      id: id,
      tripId: tripId,
      senderId: senderId,
      recipientId: recipientId,
      type: type,
      content: content,
      priority: priority,
      status: status ?? this.status,
      createdAt: createdAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      readAt: readAt ?? this.readAt,
      attachments: attachments ?? this.attachments,
      quickAlert: quickAlert,
      metadata: metadata ?? this.metadata,
      replyToMessageId: replyToMessageId,
      readByUserIds: readByUserIds ?? this.readByUserIds,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tripId': tripId,
      'senderId': senderId,
      'recipientId': recipientId,
      'type': type.toString().split('.').last,
      'content': content,
      'priority': priority.toString().split('.').last,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'deliveredAt': deliveredAt?.toIso8601String(),
      'readAt': readAt?.toIso8601String(),
      'attachments': attachments.map((a) => a.toJson()).toList(),
      'quickAlert': quickAlert?.toJson(),
      'metadata': metadata,
      'replyToMessageId': replyToMessageId,
      'readByUserIds': readByUserIds,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      tripId: json['tripId'],
      senderId: json['senderId'],
      recipientId: json['recipientId'],
      type: MessageType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      content: json['content'],
      priority: MessagePriority.values.firstWhere(
        (e) => e.toString().split('.').last == json['priority'],
      ),
      status: MessageStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      ),
      createdAt: DateTime.parse(json['createdAt']),
      deliveredAt: json['deliveredAt'] != null
          ? DateTime.parse(json['deliveredAt'])
          : null,
      readAt: json['readAt'] != null ? DateTime.parse(json['readAt']) : null,
      attachments: (json['attachments'] as List?)
              ?.map((a) => MessageAttachment.fromJson(a))
              .toList() ??
          [],
      quickAlert: json['quickAlert'] != null
          ? QuickAlert.fromJson(json['quickAlert'])
          : null,
      metadata: Map<String, dynamic>.from(json['metadata'] ?? {}),
      replyToMessageId: json['replyToMessageId'],
      readByUserIds: List<String>.from(json['readByUserIds'] ?? []),
    );
  }

  // Getters and utility methods
  bool get isGroupMessage => recipientId == null;
  bool get isDirectMessage => recipientId != null;
  bool get isSystemMessage => type == MessageType.system;
  bool get isEmergencyMessage => type == MessageType.emergency;
  bool get isQuickAlert => type == MessageType.quickAlert;
  bool get hasAttachments => attachments.isNotEmpty;
  bool get isReply => replyToMessageId != null;

  String get typeDisplay {
    switch (type) {
      case MessageType.text:
        return 'Text';
      case MessageType.voice:
        return 'Voice';
      case MessageType.image:
        return 'Image';
      case MessageType.location:
        return 'Location';
      case MessageType.emergency:
        return 'Emergency';
      case MessageType.system:
        return 'System';
      case MessageType.quickAlert:
        return 'Quick Alert';
      case MessageType.gameInvite:
        return 'Game Invite';
      case MessageType.announcement:
        return 'Announcement';
    }
  }

  String get priorityDisplay {
    switch (priority) {
      case MessagePriority.low:
        return 'Low';
      case MessagePriority.normal:
        return 'Normal';
      case MessagePriority.high:
        return 'High';
      case MessagePriority.emergency:
        return 'Emergency';
    }
  }

  String get statusDisplay {
    switch (status) {
      case MessageStatus.sending:
        return 'Sending';
      case MessageStatus.sent:
        return 'Sent';
      case MessageStatus.delivered:
        return 'Delivered';
      case MessageStatus.read:
        return 'Read';
      case MessageStatus.failed:
        return 'Failed';
    }
  }

  bool isReadBy(String userId) => readByUserIds.contains(userId);

  Message markAsRead(String userId) {
    if (isReadBy(userId)) return this;
    
    return copyWith(
      status: MessageStatus.read,
      readAt: DateTime.now(),
      readByUserIds: [...readByUserIds, userId],
    );
  }

  Message markAsDelivered() {
    if (status == MessageStatus.delivered || status == MessageStatus.read) {
      return this;
    }
    
    return copyWith(
      status: MessageStatus.delivered,
      deliveredAt: DateTime.now(),
    );
  }

  Message markAsFailed() {
    return copyWith(status: MessageStatus.failed);
  }

  String get displayTime {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
} 