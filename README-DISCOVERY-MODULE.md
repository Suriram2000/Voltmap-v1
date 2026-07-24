# VoltMap Discovery Module

Copy the included `mobile/` directory into the repository and replace matching files.

## Included

- Repository abstraction for charger data
- Mock charging-station repository
- Riverpod providers
- Search by station, network, and area
- Filters for availability, power, network, connector, and opening hours
- Station cards
- Station details screen
- In-memory favorites
- Favorites tab
- Updated bottom navigation

## Verify

```bash
cd mobile
flutter pub get
flutter analyze
flutter run
```

## Suggested commit

```bash
git add .
git commit -m "feat: add charger discovery filters details and favorites"
```

## Note

Favorites are intentionally in-memory in this module. Persistent local storage and Firebase sync are part of the next data module.
