import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../providers/app_provider.dart';
import '../constants/app_colors.dart';
import '../widgets/emergency_button_widget.dart';

class TripDashboardScreen extends StatefulWidget {
  const TripDashboardScreen({super.key});

  @override
  State<TripDashboardScreen> createState() => _TripDashboardScreenState();
}

class _TripDashboardScreenState extends State<TripDashboardScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Consumer<AppProvider>(
        builder: (context, appProvider, child) {
          final activeTrip = appProvider.activeTrip;
          
          if (activeTrip == null) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Trip Dashboard'),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              body: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: AppColors.textSecondary),
                    SizedBox(height: 16),
                    Text(
                      'No active trip found',
                      style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Please join or create a trip first',
                      style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            );
          }

          return Column(
            children: [
              _buildAppBar(context, appProvider, activeTrip),
              _buildTripStatus(context, appProvider, activeTrip),
              _buildMapPlaceholder(),
              _buildTabBar(),
              Expanded(
                child: _buildTabContent(context, appProvider),
              ),
            ],
          );
        },
      ),
      floatingActionButton: const EmergencyButtonWidget(),
    );
  }

  Widget _buildAppBar(BuildContext context, AppProvider appProvider, trip) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Navigator.of(context).pushReplacementNamed('/profile');
                }
              },
              icon: const Icon(Icons.arrow_back),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.surface,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip.name,
                    style: GoogleFonts.inter(
                      fontSize: 18,
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
            IconButton(
              onPressed: () {
                _showTripMenu(context, appProvider);
              },
              icon: Icon(MdiIcons.dotsVertical),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripStatus(BuildContext context, AppProvider appProvider, trip) {
    final stats = appProvider.tripStatistics;
    
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Expanded(
            child: _buildStatusItem(
              icon: MdiIcons.mapMarkerDistance,
              label: 'Distance',
              value: '${stats['totalDistance']?.toStringAsFixed(0) ?? '0'} km',
              color: AppColors.primary,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppColors.border,
          ),
          Expanded(
            child: _buildStatusItem(
              icon: MdiIcons.clockOutline,
              label: 'Duration',
              value: '${stats['estimatedDuration']?.inHours ?? 0}h ${(stats['estimatedDuration']?.inMinutes ?? 0) % 60}m',
              color: AppColors.secondary,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppColors.border,
          ),
          Expanded(
            child: _buildStatusItem(
              icon: MdiIcons.car,
              label: 'Vehicles',
              value: '${stats['activeVehicles']}/${stats['vehicleCount']}',
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          size: 24,
          color: color,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
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

  Widget _buildMapPlaceholder() {
    return Container(
      height: 180,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.mapBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  MdiIcons.mapMarker,
                  size: 48,
                  color: AppColors.primary,
                ),
                const SizedBox(height: 8),
                Text(
                  'Live Trip Map',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Vehicle tracking and navigation',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Map feature coming soon!')),
                  );
                },
                icon: Icon(MdiIcons.fullscreen, color: AppColors.textPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        tabs: const [
          Tab(text: 'Chat'),
          Tab(text: 'Alerts'),
          Tab(text: 'Games'),
          Tab(text: 'Settings'),
        ],
      ),
    );
  }

  Widget _buildTabContent(BuildContext context, AppProvider appProvider) {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildChatTab(context, appProvider),
        _buildAlertsTab(context, appProvider),
        _buildGamesTab(context, appProvider),
        _buildSettingsTab(context, appProvider),
      ],
    );
  }

  Widget _buildChatTab(BuildContext context, AppProvider appProvider) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Group Chat',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Chat Content
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: _buildChatContent(context, appProvider),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatContent(BuildContext context, AppProvider appProvider) {
    try {
      final messages = appProvider.tripMessages ?? [];
      
      if (messages.isEmpty) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.message_outlined,
                size: 48,
                color: AppColors.textSecondary,
              ),
              const SizedBox(height: 12),
              Text(
                'Chat with your convoy',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Send messages and stay connected with all trip members.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Chat feature coming soon!'),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.message, size: 16),
                label: const Text('Start Chatting', style: TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
            ],
          ),
        );
      }
      
      // If there are messages, show them
      return ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          if (index >= messages.length) return const SizedBox.shrink();
          
          final message = messages[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                                 Text(
                   message.senderId,
                   style: const TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 12,
                   ),
                 ),
                const SizedBox(height: 4),
                                 Text(
                   message.content,
                   style: const TextStyle(fontSize: 14),
                 ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      // Fallback UI in case of any exception
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'Chat temporarily unavailable',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please try again later'),
                    ),
                  );
                }
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildAlertsTab(BuildContext context, AppProvider appProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(MdiIcons.alertCircle, color: AppColors.warning),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Quick Alerts',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildAlertCard('Police Ahead', MdiIcons.shieldAlert, AppColors.error),
                _buildAlertCard('Fuel Stop', MdiIcons.gasStation, AppColors.warning),
                _buildAlertCard('Food Break', MdiIcons.food, AppColors.success),
                _buildAlertCard('Rest Stop', MdiIcons.bed, AppColors.secondary),
                _buildAlertCard('Road Work', MdiIcons.roadVariant, AppColors.warning),
                _buildAlertCard('Weather Alert', MdiIcons.weatherCloudy, AppColors.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertCard(String title, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title alert sent to convoy!'),
              backgroundColor: color,
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.2)),
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
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGamesTab(BuildContext context, AppProvider appProvider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Interactive Games',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          _buildGameCard(
            'Road Trip Bingo',
            'Classic travel game with custom items',
            MdiIcons.viewGrid,
            AppColors.primary,
          ),
          const SizedBox(height: 12),
          _buildGameCard(
            'License Plate Game',
            'Spot plates from different states',
            MdiIcons.car,
            AppColors.secondary,
          ),
          const SizedBox(height: 12),
          _buildGameCard(
            'Trivia Challenge',
            'Test your knowledge with friends',
            MdiIcons.lightbulb,
            AppColors.success,
          ),
          const SizedBox(height: 12),
          _buildGameCard(
            'Photo Scavenger Hunt',
            'Capture moments along the way',
            MdiIcons.camera,
            AppColors.warning,
          ),
          const SizedBox(height: 12),
          _buildGameCard(
            'Story Building',
            'Create collaborative stories together',
            MdiIcons.book,
            AppColors.accent,
          ),
          const SizedBox(height: 12),
          _buildGameCard(
            'Would You Rather',
            'Fun questions to spark conversations',
            MdiIcons.helpCircle,
            AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildGameCard(String title, String description, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title game started!'),
              backgroundColor: color,
            ),
          );
        },
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(MdiIcons.chevronRight, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTab(BuildContext context, AppProvider appProvider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trip Settings',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          _buildSettingCard(
            title: 'Notifications',
            subtitle: 'Receive trip updates and alerts',
            icon: MdiIcons.bell,
            trailing: Switch(
              value: appProvider.notificationsEnabled,
              onChanged: (value) => appProvider.toggleNotifications(),
              activeColor: AppColors.primary,
            ),
          ),
          _buildSettingCard(
            title: 'Location Sharing',
            subtitle: 'Share your location with the group',
            icon: MdiIcons.mapMarker,
            trailing: Switch(
              value: appProvider.isLocationUpdateEnabled,
              onChanged: (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(value ? 'Location sharing enabled' : 'Location sharing disabled'),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              activeColor: AppColors.primary,
            ),
          ),
          _buildSettingCard(
            title: 'Voice Chat',
            subtitle: 'Enable voice communication',
            icon: MdiIcons.microphone,
            trailing: Switch(
              value: appProvider.isVoiceChatActive,
              onChanged: (value) => appProvider.toggleVoiceChat(),
              activeColor: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          _buildActionCard(
            title: 'Emergency Contacts',
            subtitle: 'Manage emergency contact list',
            icon: MdiIcons.phone,
            color: AppColors.warning,
            onTap: () => _showEmergencyContacts(context),
          ),
          const SizedBox(height: 12),
          _buildActionCard(
            title: 'Trip Details',
            subtitle: 'View complete trip information',
            icon: MdiIcons.informationOutline,
            color: AppColors.secondary,
            onTap: () => _showTripDetails(context, appProvider),
          ),
          const SizedBox(height: 12),
          _buildActionCard(
            title: 'End Trip',
            subtitle: 'Complete and end the current trip',
            icon: MdiIcons.flagCheckered,
            color: AppColors.error,
            onTap: () => _showEndTripDialog(context, appProvider),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget trailing,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(MdiIcons.chevronRight, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  void _showTripMenu(BuildContext context, AppProvider appProvider) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(MdiIcons.share, color: AppColors.primary),
              title: const Text('Share Trip'),
              onTap: () {
                Navigator.pop(context);
                _shareTrip(context, appProvider);
              },
            ),
            ListTile(
              leading: Icon(MdiIcons.informationOutline, color: AppColors.secondary),
              title: const Text('Trip Details'),
              onTap: () {
                Navigator.pop(context);
                _showTripDetails(context, appProvider);
              },
            ),
            ListTile(
              leading: Icon(MdiIcons.cog, color: AppColors.accent),
              title: const Text('Trip Settings'),
              onTap: () {
                Navigator.pop(context);
                _tabController.animateTo(3); // Go to settings tab
              },
            ),
          ],
        ),
      ),
    );
  }

  void _shareTrip(BuildContext context, AppProvider appProvider) {
    final trip = appProvider.activeTrip!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Trip "${trip.name}" shared! Join code: ${trip.joinCode}'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _showTripDetails(BuildContext context, AppProvider appProvider) {
    final trip = appProvider.activeTrip!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(trip.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Route: ${trip.route.startPoint.name} → ${trip.route.endPoint.name}'),
            Text('Status: ${trip.statusDisplay}'),
            Text('Join Code: ${trip.joinCode}'),
            Text('Participants: ${trip.totalParticipants}'),
            Text('Vehicles: ${trip.totalVehicles}'),
            if (trip.startedAt != null) 
              Text('Started: ${trip.startedAt.toString().split('.')[0]}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showEmergencyContacts(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Emergency contacts feature coming soon!'),
        backgroundColor: AppColors.warning,
      ),
    );
  }

  void _showEndTripDialog(BuildContext context, AppProvider appProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('End Trip'),
          content: const Text(
            'Are you sure you want to end this trip? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await appProvider.endTrip();
                if (context.mounted) {
                  Navigator.of(context).pushReplacementNamed('/profile');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
              ),
              child: const Text('End Trip'),
            ),
          ],
        );
      },
    );
  }
} 