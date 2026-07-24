import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "VoltMap",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
            color: Colors.black,
          ),
        ],
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),

          children: [

            const Text(
              "Current Location",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 4),

            const Row(
              children: [

                Icon(
                  Icons.location_on,
                  color: Colors.green,
                ),

                SizedBox(width: 8),

                Expanded(
                  child: Text(
                    "Fetching location...",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )

              ],
            ),

            const SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                hintText: "Search chargers, cities, highways",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.ev_station),
                label: const Text("Find Nearby Chargers"),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Nearby Chargers",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            _chargerCard(
              "ChargeZone",
              "120 kW",
              "0.6 km",
              "Available",
              Colors.green,
            ),

            _chargerCard(
              "Statiq",
              "60 kW",
              "1.1 km",
              "Busy",
              Colors.orange,
            ),

            _chargerCard(
              "Bolt.Earth",
              "30 kW",
              "2.3 km",
              "Available",
              Colors.green,
            ),
          ],
        ),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [

          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          NavigationDestination(
            icon: Icon(Icons.map),
            label: "Map",
          ),

          NavigationDestination(
            icon: Icon(Icons.route),
            label: "Trips",
          ),

          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),

          NavigationDestination(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget _chargerCard(
    String network,
    String power,
    String distance,
    String status,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: const Icon(
            Icons.ev_station,
            color: Colors.white,
          ),
        ),
        title: Text(network),
        subtitle: Text("$power • $distance"),
        trailing: Chip(
          label: Text(status),
          backgroundColor: color.withOpacity(.15),
        ),
      ),
    );
  }
}
