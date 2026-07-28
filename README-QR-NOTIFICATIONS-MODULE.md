# VoltMap QR Scanner and Notifications Module

Included:

- Camera-based QR scanner screen
- QR payload parser and validation
- Charger-code confirmation flow
- Firebase Cloud Messaging service
- Foreground notification handling
- Notification preferences provider
- Charger availability alert model
- Android camera and notification permissions
- iOS camera permission text
- Updated charging start screen
- Updated `pubspec.yaml` dependency additions

## GitHub check-in

```bash
git add .
git commit -m "feat: add QR scanner and charger notifications"
git push
```

No local Flutter commands are required while you are only checking files into GitHub.

## Later configuration

When Firebase is connected, add real platform configuration files and enable
Firebase Cloud Messaging for Android and iOS.
