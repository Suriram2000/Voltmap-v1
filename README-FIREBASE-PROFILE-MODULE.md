# VoltMap Firebase and Profile Module

This module adds the backend structure for:

- Firebase initialization
- Firebase Authentication repository
- Authentication state provider
- Firestore user profiles
- Profile screen
- Persistent Firestore favorites repository
- Charging-session model and Firestore repository
- Firestore security rules
- Firebase configuration placeholder

## Important

This module contains safe placeholders and application structure only.

Do not commit real Firebase secrets manually. Add the official Firebase-generated files later:

- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`
- generated Firebase options file when using FlutterFire CLI

Replace placeholder values inside `mobile/firebase.json` only when configuring the real project.

## Firestore collections

```text
users/{userId}
users/{userId}/favorites/{stationId}
chargingSessions/{sessionId}
```

## Suggested commit

```bash
git add .
git commit -m "feat: add Firebase profiles favorites and charging sessions"
git push
```

No Flutter commands are required while you are only checking files into GitHub.
