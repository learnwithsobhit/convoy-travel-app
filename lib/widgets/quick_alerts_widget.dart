import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/app_provider.dart';
import '../constants/app_colors.dart';
import '../models/index.dart';

class QuickAlertsWidget extends StatelessWidget {
  const QuickAlertsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Alerts',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Send instant alerts to all convoy members',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: QuickAlert.predefined.length,
                  itemBuilder: (context, index) {
                    final alertKey = QuickAlert.predefined.keys.elementAt(index);
                    final alert = QuickAlert.predefined[alertKey]!;
                    return _buildAlertCard(alert, appProvider);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAlertCard(QuickAlert alert, AppProvider appProvider) {
    final color = AppColors.quickAlertColors[alert.type] ?? AppColors.primary;
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => _sendQuickAlert(alert, appProvider),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: color.withOpacity(0.2),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  alert.icon ?? '📢',
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                alert.message,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getSeverityText(alert.data['severity']),
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getSeverityText(dynamic severity) {
    switch (severity) {
      case 'emergency':
        return 'EMERGENCY';
      case 'high':
        return 'HIGH';
      case 'warning':
        return 'WARNING';
      case 'info':
      default:
        return 'INFO';
    }
  }

  void _sendQuickAlert(QuickAlert alert, AppProvider appProvider) {
    appProvider.sendQuickAlert(alert);
  }
} 