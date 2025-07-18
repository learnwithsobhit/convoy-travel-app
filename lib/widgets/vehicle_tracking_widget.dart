import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import '../providers/app_provider.dart';
import '../constants/app_colors.dart';

class VehicleTrackingWidget extends StatefulWidget {
  const VehicleTrackingWidget({super.key});

  @override
  State<VehicleTrackingWidget> createState() => _VehicleTrackingWidgetState();
}

class _VehicleTrackingWidgetState extends State<VehicleTrackingWidget> {
  Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;
  Set<Marker> _markers = {};

  // Mumbai to Goa route coordinates for demo
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(19.0760, 72.8777), // Mumbai coordinates
    zoom: 11.0,
  );

  @override
  void initState() {
    super.initState();
    _createMarkers();
  }

    void _createMarkers() {
    try {
      final context = this.context;
      final appProvider = Provider.of<AppProvider>(context, listen: false);
      final vehicles = appProvider.tripVehicles;

      Set<Marker> markers = {};

      // Safely iterate through vehicles
      if (vehicles.isNotEmpty) {
        for (int i = 0; i < vehicles.length; i++) {
          final vehicle = vehicles[i];
          
          // Skip vehicles without location data
          if (vehicle.currentLocation == null) continue;
          
          // Get driver name from user data
          final users = appProvider.tripParticipants;
          final driver = users.isNotEmpty 
              ? users.firstWhere(
                  (user) => user.id == vehicle.driverId,
                  orElse: () => users.first,
                )
              : null;
          
          markers.add(
            Marker(
              markerId: MarkerId(vehicle.id),
              position: LatLng(
                vehicle.currentLocation!.latitude, 
                vehicle.currentLocation!.longitude
              ),
              infoWindow: InfoWindow(
                title: vehicle.licensePlate,
                snippet: '${driver?.name ?? "Driver"} - ${vehicle.isOnline ? "Online" : "Offline"}',
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                vehicle.isOnline ? BitmapDescriptor.hueGreen : BitmapDescriptor.hueRed,
              ),
            ),
          );
        }
      }

      if (mounted) {
        setState(() {
          _markers = markers;
        });
      }
    } catch (e) {
      // Safely handle any errors in marker creation
      if (mounted) {
        setState(() {
          _markers = {};
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        final vehicles = appProvider.tripVehicles;
        
        // Update markers when vehicles change
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _createMarkers();
        });
        
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Google Maps
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _initialPosition,
                markers: _markers,
                onMapCreated: (GoogleMapController controller) {
                  if (!_controller.isCompleted) {
                    _controller.complete(controller);
                    mapController = controller;
                  }
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                compassEnabled: true,
                trafficEnabled: false,
                buildingsEnabled: true,
                indoorViewEnabled: false,
                rotateGesturesEnabled: true,
                scrollGesturesEnabled: true,
                tiltGesturesEnabled: true,
                zoomGesturesEnabled: true,
              ),
              // Vehicle count overlay
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        MdiIcons.carMultiple,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${vehicles.length} vehicles',
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
              // Center on convoy button
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton(
                  mini: true,
                  onPressed: _centerOnConvoy,
                  backgroundColor: AppColors.primary,
                  child: Icon(
                    MdiIcons.crosshairsGps,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _centerOnConvoy() async {
    if (_markers.isEmpty) return;
    
    try {
      final GoogleMapController controller = await _controller.future;
      
      // Calculate bounds to fit all vehicles
      double minLat = _markers.first.position.latitude;
      double maxLat = _markers.first.position.latitude;
      double minLng = _markers.first.position.longitude;
      double maxLng = _markers.first.position.longitude;
      
      for (final marker in _markers) {
        minLat = minLat < marker.position.latitude ? minLat : marker.position.latitude;
        maxLat = maxLat > marker.position.latitude ? maxLat : marker.position.latitude;
        minLng = minLng < marker.position.longitude ? minLng : marker.position.longitude;
        maxLng = maxLng > marker.position.longitude ? maxLng : marker.position.longitude;
      }
      
      controller.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(minLat, minLng),
            northeast: LatLng(maxLat, maxLng),
          ),
          100.0, // padding
        ),
      );
    } catch (e) {
      // Handle error silently for demo
      // Error centering on convoy ignored for production
    }
  }

} 