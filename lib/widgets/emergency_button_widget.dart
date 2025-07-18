import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../providers/app_provider.dart';
import '../constants/app_colors.dart';

class EmergencyButtonWidget extends StatefulWidget {
  const EmergencyButtonWidget({super.key});

  @override
  State<EmergencyButtonWidget> createState() => _EmergencyButtonWidgetState();
}

class _EmergencyButtonWidgetState extends State<EmergencyButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _pulseAnimation.value,
              child: FloatingActionButton.extended(
                onPressed: () => _showEmergencyDialog(context, appProvider),
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
                elevation: 8,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(MdiIcons.alert),
                    const SizedBox(width: 8),
                    Text(
                      'EMERGENCY',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                heroTag: "emergency_button",
              ),
            );
          },
        );
      },
    );
  }

  void _showEmergencyDialog(BuildContext context, AppProvider appProvider) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                MdiIcons.alert,
                color: AppColors.error,
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                'Emergency Alert',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  color: AppColors.error,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This will send an emergency alert to all convoy members and emergency contacts.',
                style: GoogleFonts.inter(fontSize: 14),
              ),
              const SizedBox(height: 16),
              Text(
                'Select emergency type:',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              _buildEmergencyOption(
                context,
                appProvider,
                'Vehicle Breakdown',
                'Car trouble or mechanical issue',
                MdiIcons.carBrakeAlert,
              ),
                             _buildEmergencyOption(
                 context,
                 appProvider,
                 'Medical Emergency',
                 'Someone needs medical assistance',
                 MdiIcons.hospitalBox,
               ),
               _buildEmergencyOption(
                 context,
                 appProvider,
                 'Accident',
                 'Vehicle accident or collision',
                 MdiIcons.car,
               ),
              _buildEmergencyOption(
                context,
                appProvider,
                'Security Issue',
                'Safety or security concern',
                MdiIcons.security,
              ),
              _buildEmergencyOption(
                context,
                appProvider,
                'Other Emergency',
                'Other urgent situation',
                MdiIcons.alertCircle,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmergencyOption(
    BuildContext context,
    AppProvider appProvider,
    String title,
    String description,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          _sendEmergencyAlert(context, appProvider, title);
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: AppColors.error,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      description,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendEmergencyAlert(
    BuildContext context,
    AppProvider appProvider,
    String emergencyType,
  ) {
    appProvider.sendEmergencyAlert(
      'EMERGENCY: $emergencyType - Immediate assistance needed!',
    );

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              MdiIcons.checkCircle,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Emergency alert sent to all convoy members and emergency contacts',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.error,
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
      ),
    );

    // Show follow-up dialog
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && context.mounted) {
        _showEmergencyConfirmationDialog(context, emergencyType);
      }
    });
  }

  void _showEmergencyConfirmationDialog(BuildContext context, String emergencyType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                MdiIcons.checkCircle,
                color: AppColors.success,
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                'Alert Sent',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Emergency alert for "$emergencyType" has been sent to:',
                style: GoogleFonts.inter(fontSize: 14),
              ),
              const SizedBox(height: 16),
              _buildNotificationTarget('All convoy members', MdiIcons.accountGroup),
              _buildNotificationTarget('Emergency contacts', MdiIcons.phone),
              _buildNotificationTarget('Trip leader', MdiIcons.crown),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      MdiIcons.information,
                      color: AppColors.accent,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Help is on the way. Stay calm and wait for assistance.',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.accent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
              ),
              child: Text(
                'OK',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNotificationTarget(String target, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            MdiIcons.checkCircle,
            color: AppColors.success,
            size: 16,
          ),
          const SizedBox(width: 8),
          Icon(
            icon,
            color: AppColors.textSecondary,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            target,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
} 