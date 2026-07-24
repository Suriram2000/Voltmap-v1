import 'package:flutter/material.dart';

import '../map/map_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final _pages = const [
    _HomeDashboard(),
    MapScreen(),
    _ComingSoon(title: 'Trips', icon: Icons.route),
    _ComingSoon(title: 'Favorites', icon: Icons.favorite),
    _ComingSoon(title: 'Profile', icon: Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) {
          setState(() => _selectedIndex = value);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.map), label: 'Map'),
          NavigationDestination(icon: Icon(Icons.route), label: 'Trips'),
          NavigationDestination(icon: Icon(Icons.favorite), label: 'Favorites'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class _HomeDashboard extends StatelessWidget {
  const _HomeDashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'VoltMap',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Find the right charger, faster.',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Compare networks, charging speed, availability, and price.',
          ),
          const SizedBox(height: 20),
          const SearchBar(
            hintText: 'Search chargers, cities, or highways',
            leading: Icon(Icons.search),
            trailing: [Icon(Icons.tune)],
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.near_me),
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text('Find Nearby Chargers'),
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'Nearby Chargers',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 12),
          const _ChargerCard(
            network: 'ChargeZone',
            details: '120 kW • 0.8 km',
            status: 'Available',
            statusColor: Colors.green,
          ),
          const _ChargerCard(
            network: 'Statiq',
            details: '60 kW • 1.7 km',
            status: 'Busy',
            statusColor: Colors.orange,
          ),
          const _ChargerCard(
            network: 'Bolt.Earth',
            details: '30 kW • 2.4 km',
            status: 'Available',
            statusColor: Colors.green,
          ),
        ],
      ),
    );
  }
}

class _ChargerCard extends StatelessWidget {
  const _ChargerCard({
    required this.network,
    required this.details,
    required this.status,
    required this.statusColor,
  });

  final String network;
  final String details;
  final String status;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: CircleAvatar(
          backgroundColor: statusColor.withValues(alpha: 0.14),
          child: Icon(Icons.ev_station, color: statusColor),
        ),
        title: Text(
          network,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(details),
        trailing: Chip(
          label: Text(status),
          side: BorderSide.none,
          backgroundColor: statusColor.withValues(alpha: 0.14),
        ),
      ),
    );
  }
}

class _ComingSoon extends StatelessWidget {
  const _ComingSoon({required this.title, required this.icon});
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64),
            const SizedBox(height: 12),
            Text('$title module coming next'),
          ],
        ),
      ),
    );
  }
}
