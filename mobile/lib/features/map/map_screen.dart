import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/location/location_service.dart';
import '../../shared/models/charging_station.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _fallback = LatLng(17.3850, 78.4867);
  final _locationService = const LocationService();
  GoogleMapController? _controller;
  ChargingStation? _selected;
  bool _locating = false;

  final List<ChargingStation> _stations = const [
    ChargingStation(
      id: 'cz-hyd-01',
      name: 'ChargeZone Hitech City',
      network: 'ChargeZone',
      position: LatLng(17.4435, 78.3772),
      distanceKm: 0.8,
      maxPowerKw: 120,
      availableConnectors: 2,
      totalConnectors: 4,
      pricePerKwh: 22,
      status: ChargerStatus.available,
      address: 'Hitech City Road, Hyderabad',
    ),
    ChargingStation(
      id: 'statiq-hyd-01',
      name: 'Statiq Jubilee Hills',
      network: 'Statiq',
      position: LatLng(17.4326, 78.4071),
      distanceKm: 1.7,
      maxPowerKw: 60,
      availableConnectors: 0,
      totalConnectors: 2,
      pricePerKwh: 19,
      status: ChargerStatus.busy,
      address: 'Road No. 36, Jubilee Hills, Hyderabad',
    ),
    ChargingStation(
      id: 'bolt-hyd-01',
      name: 'Bolt.Earth Madhapur',
      network: 'Bolt.Earth',
      position: LatLng(17.4483, 78.3915),
      distanceKm: 2.4,
      maxPowerKw: 30,
      availableConnectors: 1,
      totalConnectors: 2,
      pricePerKwh: 16,
      status: ChargerStatus.available,
      address: 'Madhapur Main Road, Hyderabad',
    ),
  ];

  Set<Marker> get _markers => _stations.map((station) {
        final hue = switch (station.status) {
          ChargerStatus.available => BitmapDescriptor.hueGreen,
          ChargerStatus.busy => BitmapDescriptor.hueOrange,
          ChargerStatus.offline => BitmapDescriptor.hueRed,
        };

        return Marker(
          markerId: MarkerId(station.id),
          position: station.position,
          icon: BitmapDescriptor.defaultMarkerWithHue(hue),
          infoWindow: InfoWindow(
            title: station.name,
            snippet: '${station.maxPowerKw} kW • ${station.network}',
          ),
          onTap: () => setState(() => _selected = station),
        );
      }).toSet();

  Future<void> _goToCurrentLocation() async {
    setState(() => _locating = true);
    try {
      final Position position = await _locationService.determinePosition();
      await _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 14.5,
          ),
        ),
      );
    } on Exception catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    } finally {
      if (mounted) setState(() => _locating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                const CameraPosition(target: _fallback, zoom: 11.5),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapToolbarEnabled: false,
            onMapCreated: (controller) {
              _controller = controller;
              _goToCurrentLocation();
            },
            onTap: (_) => setState(() => _selected = null),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SearchBar(
                hintText: 'Search chargers, cities, or highways',
                leading: const Icon(Icons.search),
                trailing: const [Icon(Icons.tune)],
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Search and filters are in the next module.'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: _selected == null ? 24 : 230,
            child: FloatingActionButton.small(
              heroTag: 'current-location',
              onPressed: _locating ? null : _goToCurrentLocation,
              child: _locating
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.my_location),
            ),
          ),
          if (_selected != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: _StationPanel(station: _selected!),
            ),
        ],
      ),
    );
  }
}

class _StationPanel extends StatelessWidget {
  const _StationPanel({required this.station});
  final ChargingStation station;

  @override
  Widget build(BuildContext context) {
    final statusColor = switch (station.status) {
      ChargerStatus.available => Colors.green,
      ChargerStatus.busy => Colors.orange,
      ChargerStatus.offline => Colors.red,
    };

    return Material(
      elevation: 12,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              station.name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 4),
            Text('${station.network} • ${station.distanceKm} km'),
            Text(station.address),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                Chip(label: Text('${station.maxPowerKw} kW')),
                Chip(
                  label: Text(
                    '${station.availableConnectors}/${station.totalConnectors} available',
                  ),
                  backgroundColor: statusColor.withValues(alpha: 0.15),
                ),
                Chip(label: Text('₹${station.pricePerKwh.toInt()}/kWh')),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Details'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.navigation),
                    label: const Text('Navigate'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
