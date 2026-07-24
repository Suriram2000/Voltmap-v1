import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../shared/models/charging_station.dart';
import 'station_repository.dart';

class MockStationRepository implements StationRepository {
  const MockStationRepository();

  @override
  Future<List<ChargingStation>> fetchStations() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));

    return const [
      ChargingStation(
        id: 'chargezone-hitech-city',
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
        connectorTypes: [ConnectorType.ccs2, ConnectorType.chademo],
        isOpen24Hours: true,
      ),
      ChargingStation(
        id: 'statiq-jubilee-hills',
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
        connectorTypes: [ConnectorType.ccs2, ConnectorType.type2],
        isOpen24Hours: true,
      ),
      ChargingStation(
        id: 'bolt-earth-madhapur',
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
        connectorTypes: [ConnectorType.type2],
        isOpen24Hours: false,
      ),
      ChargingStation(
        id: 'jiobp-banjara-hills',
        name: 'Jio-bp Pulse Banjara Hills',
        network: 'Jio-bp Pulse',
        position: LatLng(17.4156, 78.4347),
        distanceKm: 3.2,
        maxPowerKw: 60,
        availableConnectors: 3,
        totalConnectors: 4,
        pricePerKwh: 21,
        status: ChargerStatus.available,
        address: 'Banjara Hills Road No. 1, Hyderabad',
        connectorTypes: [ConnectorType.ccs2, ConnectorType.gbT],
        isOpen24Hours: true,
      ),
      ChargingStation(
        id: 'tata-power-begumpet',
        name: 'Tata Power EZ Charge Begumpet',
        network: 'Tata Power',
        position: LatLng(17.4449, 78.4666),
        distanceKm: 4.1,
        maxPowerKw: 50,
        availableConnectors: 0,
        totalConnectors: 2,
        pricePerKwh: 20,
        status: ChargerStatus.offline,
        address: 'Begumpet Main Road, Hyderabad',
        connectorTypes: [ConnectorType.ccs2, ConnectorType.bharatDc001],
        isOpen24Hours: false,
      ),
    ];
  }
}
