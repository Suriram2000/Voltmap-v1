import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/charging_station.dart';
import '../application/station_filters.dart';
import '../application/station_providers.dart';
import 'station_details_screen.dart';
import 'widgets/filter_sheet.dart';
import 'widgets/station_card.dart';

class DiscoveryScreen extends ConsumerWidget {
  const DiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stations = ref.watch(filteredStationsProvider);
    final favorites = ref.watch(favoriteStationIdsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Discover Chargers',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: SearchBar(
              hintText: 'Search station, network, or area',
              leading: const Icon(Icons.search),
              trailing: [
                IconButton(
                  tooltip: 'Filters',
                  onPressed: () => _openFilters(context, ref),
                  icon: const Icon(Icons.tune),
                ),
              ],
              onChanged: (value) {
                ref.read(stationSearchQueryProvider.notifier).state = value;
              },
            ),
          ),
          Expanded(
            child: stations.when(
              data: (items) {
                if (items.isEmpty) {
                  return const Center(
                    child: Text('No chargers match your search and filters.'),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => ref.refresh(stationsProvider.future),
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final station = items[index];
                      final isFavorite = favorites.contains(station.id);

                      return StationCard(
                        station: station,
                        isFavorite: isFavorite,
                        onFavoritePressed: () =>
                            _toggleFavorite(ref, station.id),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => StationDetailsScreen(
                              station: station,
                              isFavorite: isFavorite,
                              onFavoritePressed: () =>
                                  _toggleFavorite(ref, station.id),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text('Unable to load chargers: $error'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleFavorite(WidgetRef ref, String stationId) {
    final current = ref.read(favoriteStationIdsProvider);
    final updated = {...current};

    updated.contains(stationId)
        ? updated.remove(stationId)
        : updated.add(stationId);

    ref.read(favoriteStationIdsProvider.notifier).state = updated;
  }

  Future<void> _openFilters(BuildContext context, WidgetRef ref) async {
    final allStations = await ref.read(stationsProvider.future);
    if (!context.mounted) return;

    final networks = allStations.map((station) => station.network).toSet().toList()
      ..sort();

    final result = await showModalBottomSheet<StationFilters>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => FilterSheet(
        initialFilters: ref.read(stationFiltersProvider),
        networks: networks,
      ),
    );

    if (result != null) {
      ref.read(stationFiltersProvider.notifier).state = result;
    }
  }
}
