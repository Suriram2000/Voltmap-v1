import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../discovery/application/station_providers.dart';
import '../discovery/presentation/station_details_screen.dart';
import '../discovery/presentation/widgets/station_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteIds = ref.watch(favoriteStationIdsProvider);
    final stations = ref.watch(stationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: stations.when(
        data: (items) {
          final favorites =
              items.where((station) => favoriteIds.contains(station.id)).toList();

          if (favorites.isEmpty) {
            return const Center(
              child: Text('Save chargers to see them here.'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final station = favorites[index];

              return StationCard(
                station: station,
                isFavorite: true,
                onFavoritePressed: () {
                  final updated = {...favoriteIds}..remove(station.id);
                  ref.read(favoriteStationIdsProvider.notifier).state = updated;
                },
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StationDetailsScreen(
                      station: station,
                      isFavorite: true,
                      onFavoritePressed: () {
                        final updated = {...favoriteIds}..remove(station.id);
                        ref.read(favoriteStationIdsProvider.notifier).state =
                            updated;
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Unable to load favorites: $error')),
      ),
    );
  }
}
