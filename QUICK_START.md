# Quick Start - Demo Mode Feature

## What Was Added

Your Flutter attendance app now has a **Demo Mode** that automatically activates when the API server is unreachable. This allows the app to function with sample data even when offline.

## Key Features

✅ **Automatic Detection** - Checks API connectivity on startup  
✅ **User Confirmation** - Shows a dialog before entering demo mode  
✅ **Visual Indicator** - Orange banner shows when in demo mode  
✅ **Mock Data** - Realistic sample data for all endpoints  
✅ **Seamless Experience** - All features work normally with mock data

## Files Created

```
lib/
├── src/
│   ├── components/
│   │   ├── demo_mode_banner.dart       ← Visual banner
│   │   └── demo_mode_dialog.dart       ← Confirmation dialog
│   ├── data/
│   │   ├── mock/
│   │   │   └── mock_data.dart          ← Mock JSON responses
│   │   ├── provider/
│   │   │   └── demo_mode_provider.dart ← State management
│   │   └── services/
│   │       └── api_service.dart        ← Unified API layer
```

## How to Test

### Option 1: Stop Your Backend Server

```bash
# Stop your API server
# Then run the Flutter app
flutter run -d chrome
```

### Option 2: Change API URL

Edit `lib/src/data/server/url.dart`:

```dart
static String host = "http://invalid-url.com/api/";
```

### Option 3: Test with Real Server

Keep your server running - the app will work normally without demo mode.

## What Happens

1. **App Starts** → Checks API connectivity (5 second timeout)
2. **If API Unreachable** → Shows confirmation dialog
3. **User Confirms** → Enters demo mode with orange banner
4. **All Features Work** → Using mock data from `mock_data.dart`

## Mock Data Included

### Establishments (5 records)

- Main Campus (Manila)
- North Campus (Quezon City)
- South Campus (Makati)
- East Campus (Pasig)
- West Campus (Parañaque)

### Announcements (5 records)

- Welcome to New Semester
- System Maintenance Notice
- Holiday Schedule Update
- New Attendance Policy
- Training Workshop Announcement

## Demo Mode Behavior

| Action               | Demo Mode Behavior                        |
| -------------------- | ----------------------------------------- |
| **GET** requests     | Returns mock data instantly (500ms delay) |
| **POST** requests    | Returns success message (800ms delay)     |
| **DELETE** requests  | Returns success message (600ms delay)     |
| **Data persistence** | No actual changes saved                   |

## Visual Indicators

When in demo mode, you'll see:

- 🟧 Orange banner at the top: "DEMO MODE - Using Sample Data"
- 🔴 "OFFLINE" badge on the banner
- All features work normally

## Exiting Demo Mode

Currently, demo mode persists for the app session. To exit:

1. Restart the app
2. Ensure API server is running
3. App will connect normally

## Adding More Mock Data

Edit `lib/src/data/mock/mock_data.dart` to add more sample records:

```dart
static const Map<String, dynamic> establishmentResponse = {
  "data": [
    {
      "id": 6,
      "establishment_name": "Your New Campus",
      // ... add your fields
    }
  ]
};
```

## Configuration

### Change Timeout Duration

In `lib/src/data/services/api_service.dart`:

```dart
static const Duration _connectionTimeout = Duration(seconds: 5);
```

### Adjust Mock Delays

In `lib/src/data/services/api_service.dart`:

```dart
await Future.delayed(const Duration(milliseconds: 500)); // Adjust here
```

## Next Steps

1. ✅ Run the app and test demo mode
2. ✅ Verify all pages work with mock data
3. ✅ Customize mock data for your needs
4. ✅ Test with real API to ensure normal operation

## Need Help?

See `DEMO_MODE_GUIDE.md` for detailed documentation.

---

**Ready to test!** Just run your app with the server stopped to see demo mode in action. 🚀
