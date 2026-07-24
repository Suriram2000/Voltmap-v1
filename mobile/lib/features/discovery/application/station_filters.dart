import '../../../shared/models/charging_station.dart';

class StationFilters {
  const StationFilters({
    this.availableOnly = false,
    this.minimumPowerKw = 0,
    this.networks = const {},
    this.connectorTypes = const {},
    this.open24HoursOnly = false,
  });

  final bool availableOnly;
  final int minimumPowerKw;
  final Set<String> networks;
  final Set<ConnectorType> connectorTypes;
  final bool open24HoursOnly;

  StationFilters copyWith({
    bool? availableOnly,
    int? minimumPowerKw,
    Set<String>? networks,
    Set<ConnectorType>? connectorTypes,
    bool? open24HoursOnly,
  }) {
    return StationFilters(
      availableOnly: availableOnly ?? this.availableOnly,
      minimumPowerKw: minimumPowerKw ?? this.minimumPowerKw,
      networks: networks ?? this.networks,
      connectorTypes: connectorTypes ?? this.connectorTypes,
      open24HoursOnly: open24HoursOnly ?? this.open24HoursOnly,
    );
  }

  bool matches(ChargingStation station) {
    if (availableOnly && !station.isAvailable) return false;
    if (station.maxPowerKw < minimumPowerKw) return false;
    if (open24HoursOnly && !station.isOpen24Hours) return false;
    if (networks.isNotEmpty && !networks.contains(station.network)) return false;

    if (connectorTypes.isNotEmpty &&
        !station.connectorTypes.any(connectorTypes.contains)) {
      return false;
    }

    return true;
  }
}
