# VoltMap Trip Planner Module

Copy the included `mobile/` folder over your existing repository.

## Included

- Trip-planning form
- Origin and destination validation
- Vehicle-range selector
- Starting-charge selector
- Recommended charging stops
- Estimated distance and trip duration
- Google Maps external navigation
- Updated station-details navigation button
- Updated bottom navigation
- Updated `pubspec.yaml` with `url_launcher`

## Important

Run:

```bash
cd mobile
flutter pub get
flutter analyze
flutter run
```

The current route calculation is deterministic mock logic so the UI can be completed before connecting Google Routes API or another routing provider.

## Suggested commit

```bash
git add .
git commit -m "feat: add EV trip planner and external navigation"
```
