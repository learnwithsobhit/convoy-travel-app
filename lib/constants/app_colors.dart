import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF2563EB); // Blue-600
  static const Color primaryLight = Color(0xFF3B82F6); // Blue-500
  static const Color primaryDark = Color(0xFF1D4ED8); // Blue-700
  
  // Secondary Colors
  static const Color secondary = Color(0xFF10B981); // Emerald-500
  static const Color secondaryLight = Color(0xFF34D399); // Emerald-400
  static const Color secondaryDark = Color(0xFF059669); // Emerald-600
  
  // Accent Colors
  static const Color accent = Color(0xFFF59E0B); // Amber-500
  static const Color accentLight = Color(0xFFFBBF24); // Amber-400
  static const Color accentDark = Color(0xFFD97706); // Amber-600
  
  // Status Colors
  static const Color success = Color(0xFF10B981); // Emerald-500
  static const Color warning = Color(0xFFF59E0B); // Amber-500
  static const Color error = Color(0xFFEF4444); // Red-500
  static const Color info = Color(0xFF3B82F6); // Blue-500
  
  // Text Colors
  static const Color textPrimary = Color(0xFF111827); // Gray-900
  static const Color textSecondary = Color(0xFF6B7280); // Gray-500
  static const Color textTertiary = Color(0xFF9CA3AF); // Gray-400
  static const Color textLight = Color(0xFFFFFFFF); // White
  
  // Background Colors
  static const Color background = Color(0xFFFFFFFF); // White
  static const Color backgroundLight = Color(0xFFF9FAFB); // Gray-50
  static const Color surface = Color(0xFFF3F4F6); // Gray-100
  static const Color surfaceLight = Color(0xFFF9FAFB); // Gray-50
  
  // Border Colors
  static const Color border = Color(0xFFE5E7EB); // Gray-200
  static const Color borderLight = Color(0xFFF3F4F6); // Gray-100
  static const Color borderDark = Color(0xFFD1D5DB); // Gray-300
  
  // Shadow Colors
  static const Color shadow = Color(0x1A000000); // Black with 10% opacity
  static const Color shadowLight = Color(0x0D000000); // Black with 5% opacity
  static const Color shadowDark = Color(0x26000000); // Black with 15% opacity
  
  // Vehicle Status Colors
  static const Color vehicleActive = Color(0xFF10B981); // Emerald-500
  static const Color vehicleStopped = Color(0xFFF59E0B); // Amber-500
  static const Color vehicleEmergency = Color(0xFFEF4444); // Red-500
  static const Color vehicleOffline = Color(0xFF6B7280); // Gray-500
  
  // Trip Status Colors
  static const Color tripPlanning = Color(0xFF3B82F6); // Blue-500
  static const Color tripActive = Color(0xFF10B981); // Emerald-500
  static const Color tripPaused = Color(0xFFF59E0B); // Amber-500
  static const Color tripCompleted = Color(0xFF6B7280); // Gray-500
  static const Color tripCancelled = Color(0xFFEF4444); // Red-500
  
  // Message Priority Colors
  static const Color messageLow = Color(0xFF6B7280); // Gray-500
  static const Color messageNormal = Color(0xFF3B82F6); // Blue-500
  static const Color messageHigh = Color(0xFFF59E0B); // Amber-500
  static const Color messageEmergency = Color(0xFFEF4444); // Red-500
  
  // Map Colors
  static const Color mapBackground = Color(0xFFF3F4F6); // Gray-100
  static const Color routeLine = Color(0xFF2563EB); // Blue-600
  static const Color vehicleMarker = Color(0xFF10B981); // Emerald-500
  static const Color waypointMarker = Color(0xFFF59E0B); // Amber-500
  
  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF2563EB), // Blue-600
    Color(0xFF3B82F6), // Blue-500
  ];
  
  static const List<Color> secondaryGradient = [
    Color(0xFF10B981), // Emerald-500
    Color(0xFF34D399), // Emerald-400
  ];
  
  static const List<Color> accentGradient = [
    Color(0xFFF59E0B), // Amber-500
    Color(0xFFFBBF24), // Amber-400
  ];
  
  static const List<Color> emergencyGradient = [
    Color(0xFFEF4444), // Red-500
    Color(0xFFF87171), // Red-400
  ];
  
  // Utility Methods
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
  
  static Color getVehicleStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return vehicleActive;
      case 'stopped':
        return vehicleStopped;
      case 'emergency':
        return vehicleEmergency;
      case 'offline':
      default:
        return vehicleOffline;
    }
  }
  
  static Color getTripStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'planning':
        return tripPlanning;
      case 'active':
        return tripActive;
      case 'paused':
        return tripPaused;
      case 'completed':
        return tripCompleted;
      case 'cancelled':
        return tripCancelled;
      default:
        return textSecondary;
    }
  }
  
  static Color getMessagePriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'low':
        return messageLow;
      case 'normal':
        return messageNormal;
      case 'high':
        return messageHigh;
      case 'emergency':
        return messageEmergency;
      default:
        return messageNormal;
    }
  }
  
  // Common color combinations
  static const Map<String, Color> quickAlertColors = {
    'cops_ahead': warning,
    'gas_needed': info,
    'food_break': secondary,
    'bathroom_break': accent,
    'vehicle_trouble': error,
    'wrong_turn': warning,
    'slow_down': warning,
    'speed_up': info,
  };
} 