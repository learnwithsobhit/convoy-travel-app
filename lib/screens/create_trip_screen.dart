import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../providers/app_provider.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_button.dart';

class CreateTripScreen extends StatefulWidget {
  const CreateTripScreen({super.key});

  @override
  State<CreateTripScreen> createState() => _CreateTripScreenState();
}

class _CreateTripScreenState extends State<CreateTripScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tripNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _destinationController = TextEditingController();
  
  DateTime _selectedStartTime = DateTime.now().add(const Duration(hours: 1));

  @override
  void dispose() {
    _tripNameController.dispose();
    _descriptionController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          'Create New Trip',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<AppProvider>(
        builder: (context, appProvider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderSection(),
                  const SizedBox(height: 32),
                  _buildTripDetailsSection(),
                  const SizedBox(height: 32),
                  _buildStartTimeSection(),
                  const SizedBox(height: 32),
                  _buildFeaturesSection(),
                  const SizedBox(height: 48),
                  _buildCreateButton(context, appProvider),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.primaryGradient,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(
            MdiIcons.carMultiple,
            size: 64,
            color: Colors.white,
          ),
          const SizedBox(height: 16),
          Text(
            'Plan Your Group Adventure',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Create a new convoy trip and invite your friends to join the journey.',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTripDetailsSection() {
    return Container(
      padding: const EdgeInsets.all(24),
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
          Text(
            'Trip Details',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _tripNameController,
            decoration: const InputDecoration(
              labelText: 'Trip Name',
              hintText: 'Enter a memorable trip name',
              prefixIcon: Icon(Icons.flag),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a trip name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _destinationController,
            decoration: const InputDecoration(
              labelText: 'Destination',
              hintText: 'Where are you heading?',
              prefixIcon: Icon(Icons.location_on),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a destination';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description (Optional)',
              hintText: 'Tell your group about this trip',
              prefixIcon: Icon(Icons.description),
            ),
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildStartTimeSection() {
    return Container(
      padding: const EdgeInsets.all(24),
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
          Text(
            'Start Time',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                MdiIcons.clockOutline,
                color: AppColors.primary,
              ),
            ),
            title: Text(
              'Departure Time',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              '${_selectedStartTime.day}/${_selectedStartTime.month}/${_selectedStartTime.year} at ${_selectedStartTime.hour.toString().padLeft(2, '0')}:${_selectedStartTime.minute.toString().padLeft(2, '0')}',
              style: GoogleFonts.inter(
                color: AppColors.textSecondary,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
            ),
            onTap: _selectStartTime,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Container(
      padding: const EdgeInsets.all(24),
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
          Text(
            'Included Features',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          _buildFeatureItem(
            icon: MdiIcons.mapMarkerMultiple,
            title: 'Real-time Vehicle Tracking',
            description: 'Track all vehicles in your convoy',
            color: AppColors.primary,
          ),
          _buildFeatureItem(
            icon: MdiIcons.chat,
            title: 'Group Communication',
            description: 'Chat and quick alerts system',
            color: AppColors.secondary,
          ),
          _buildFeatureItem(
            icon: MdiIcons.shieldCheck,
            title: 'Emergency Features',
            description: 'One-tap emergency alerts',
            color: AppColors.error,
          ),
          _buildFeatureItem(
            icon: MdiIcons.gamepadVariant,
            title: 'Interactive Games',
            description: 'Entertainment for the journey',
            color: AppColors.accent,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: color,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
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
            Icons.check_circle,
            color: color,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildCreateButton(BuildContext context, AppProvider appProvider) {
    return CustomButton(
      onPressed: appProvider.isLoading ? null : () => _createTrip(context, appProvider),
      text: 'Create Trip',
      icon: MdiIcons.plus,
      style: CustomButtonStyle.primary,
      isLoading: appProvider.isLoading,
    );
  }

  Future<void> _selectStartTime() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _selectedStartTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null && mounted) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedStartTime),
      );

      if (time != null) {
        setState(() {
          _selectedStartTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  Future<void> _createTrip(BuildContext context, AppProvider appProvider) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await appProvider.createTrip(
      name: _tripNameController.text.trim(),
      description: _descriptionController.text.trim(),
      destination: _destinationController.text.trim(),
      startTime: _selectedStartTime,
    );

    if (mounted) {
      if (appProvider.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(appProvider.errorMessage!),
            backgroundColor: AppColors.error,
          ),
        );
      } else {
        Navigator.of(context).pushNamed('/trip-dashboard');
      }
    }
  }
} 