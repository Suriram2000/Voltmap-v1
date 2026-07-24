import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/charging_station.dart';
import '../data/mock_station_repository.dart';
import '../data/station_repository.dart';
import 'station_filters.dart';

final stationRepositoryProvider = Provider<StationRepository>(
  (ref) => const MockStationRepository(),
);

final stationsProvider = FutureProvider<List<ChargingStation>>(
  (ref) => ref.watch(stationRepositoryProvider).fetchStations(),
);

final stationSearchQueryProvider = StateProvider<String>((ref) => '');
final stationFiltersProvider =
    StateProvider<StationFilters>((ref) => const StationFilters());
final favoriteStationIdsProvider =
    StateProvider<Set<String>>((ref) => <String>{});

final filteredStationsProvider =
    Provider<AsyncValue<List<ChargingStation>>>((ref) {
  final stations = ref.watch(stationsProvider);
  final query = ref.watch(stationSearchQueryProvider).trim().toLowerCase();
  final filters = ref.watch(stationFiltersProvider);

  return stations.whenData(
    (items) => items.where((station) {
      final matchesSearch = query.isEmpty ||
          station.name.toLowerCase().contains(query) ||
          station.network.toLowerCase().contains(query) ||
          station.address.toLowerCase().contains(query);

      return matchesSearch && filters.matches(station);
    }).toList()
      ..sort((a, b) => a.distanceKm.compareTo(b.distanceKm)),
  );
});
