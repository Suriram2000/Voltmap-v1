import 'package:flutter/material.dart';

import '../../../../shared/models/charging_station.dart';
import '../../application/station_filters.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({
    required this.initialFilters,
    required this.networks,
    super.key,
  });

  final StationFilters initialFilters;
  final List<String> networks;

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late bool _availableOnly;
  late bool _open24HoursOnly;
  late double _minimumPower;
  late Set<String> _networks;
  late Set<ConnectorType> _connectors;

  @override
  void initState() {
    super.initState();
    _availableOnly = widget.initialFilters.availableOnly;
    _open24HoursOnly = widget.initialFilters.open24HoursOnly;
    _minimumPower = widget.initialFilters.minimumPowerKw.toDouble();
    _networks = {...widget.initialFilters.networks};
    _connectors = {...widget.initialFilters.connectorTypes};
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              'Filter chargers',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Available now'),
              value: _availableOnly,
              onChanged: (value) => setState(() => _availableOnly = value),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Open 24 hours'),
              value: _open24HoursOnly,
              onChanged: (value) => setState(() => _open24HoursOnly = value),
            ),
            const SizedBox(height: 8),
            Text('Minimum power: ${_minimumPower.round()} kW'),
            Slider(
              min: 0,
              max: 150,
              divisions: 6,
              label: '${_minimumPower.round()} kW',
              value: _minimumPower,
              onChanged: (value) => setState(() => _minimumPower = value),
            ),
            const SizedBox(height: 12),
            Text(
              'Networks',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Wrap(
              spacing: 8,
              children: widget.networks.map((network) {
                return FilterChip(
                  label: Text(network),
                  selected: _networks.contains(network),
                  onSelected: (selected) {
                    setState(() {
                      selected ? _networks.add(network) : _networks.remove(network);
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Text(
              'Connector types',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Wrap(
              spacing: 8,
              children: ConnectorType.values.map((connector) {
                return FilterChip(
                  label: Text(connector.label),
                  selected: _connectors.contains(connector),
                  onSelected: (selected) {
                    setState(() {
                      selected
                          ? _connectors.add(connector)
                          : _connectors.remove(connector);
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(
                      context,
                      const StationFilters(),
                    ),
                    child: const Text('Reset'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Navigator.pop(
                      context,
                      StationFilters(
                        availableOnly: _availableOnly,
                        minimumPowerKw: _minimumPower.round(),
                        networks: _networks,
                        connectorTypes: _connectors,
                        open24HoursOnly: _open24HoursOnly,
                      ),
                    ),
                    child: const Text('Apply'),
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
