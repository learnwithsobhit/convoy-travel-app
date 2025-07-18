import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../services/mock_data_service.dart';

class TripHistoryCard extends StatelessWidget {
  const TripHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Get a completed trip from mock data
    final completedTrips = MockDataService.trips
        .where((trip) => trip.isCompleted)
        .toList();
    
    if (completedTrips.isEmpty) {
      return const SizedBox.shrink();
    }

    final trip = completedTrips.first;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.getTripStatusColor(trip.statusDisplay).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 20,
                  color: AppColors.getTripStatusColor(trip.statusDisplay),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.name,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      '${trip.route.startPoint.name} → ${trip.route.endPoint.name}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.getTripStatusColor(trip.statusDisplay).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  trip.statusDisplay,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.getTripStatusColor(trip.statusDisplay),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildInfoItem(
                icon: Icons.people,
                label: '${trip.totalParticipants} people',
              ),
              const SizedBox(width: 16),
              _buildInfoItem(
                icon: Icons.directions_car,
                label: '${trip.totalVehicles} vehicles',
              ),
              const SizedBox(width: 16),
              _buildInfoItem(
                icon: Icons.schedule,
                label: trip.totalDuration != null 
                    ? '${trip.totalDuration!.inHours}h ${trip.totalDuration!.inMinutes % 60}m'
                    : 'N/A',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
} 