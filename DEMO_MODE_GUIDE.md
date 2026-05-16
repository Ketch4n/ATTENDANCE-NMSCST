# Demo Mode Implementation Guide

## Overview

This Flutter application now includes a **Demo Mode** feature that automatically detects API connectivity issues and offers to switch to a demo mode using mock data. This ensures the application remains functional even when the backend server is unavailable.

## Features

### 1. **Automatic API Connectivity Detection**

- On app startup, the system checks if the API server is reachable
- Uses a 5-second timeout to avoid long waiting times
- Checks both `/health` endpoint and base URL

### 2. **Demo Mode Confirmation Dialog**

- If API is unreachable, a user-friendly dialog appears
- Explains why the connection failed
- Offers to continue in Demo Mode with sample data
- Users can cancel to retry later

### 3. **Visual Demo Mode Indicator**

- Orange banner at the top of the app when in Demo Mode
- Shows "DEMO MODE - Using Sample Data" with an OFFLINE badge
- Clearly indicates the app is using mock data

### 4. **Mock Data Responses**

- Realistic sample data for all API endpoints
- Includes:
  - **Establishments**: 5 sample establishments with locations
  - **Announcements**: 5 sample announcements
  - Success/error responses for POST/DELETE operations

## Architecture

### New Files Created

```
lib/
├── src/
│   ├── components/
│   │   ├── demo_mode_banner.dart       # Visual indicator banner
│   │   └── demo_mode_dialog.dart       # Confirmation modal
│   ├── data/
│   │   ├── mock/
│   │   │   └── mock_data.dart          # All mock JSON responses
│   │   ├── provider/
│   │   │   └── demo_mode_provider.dart # State management
│   │   └── services/
│   │       └── api_service.dart        # Unified API service layer
```

### Modified Files

- `lib/main.dart` - Added connectivity check and demo mode provider
- `lib/src/pages/establishment/functions/get.dart` - Uses ApiService
- `lib/src/pages/establishment/functions/post.dart` - Uses ApiService
- `lib/src/pages/announcement/functions/get.dart` - Uses ApiService
- `lib/src/pages/announcement/functions/delete.dart` - Uses ApiService
- `lib/src/pages/establishment/establishment_page.dart` - Passes demo mode flag
- `lib/src/pages/announcement/announcement_page.dart` - Passes demo mode flag

## How It Works

### 1. App Initialization Flow

```dart
main()
  ↓
Initialize Firebase
  ↓
Add DemoModeProvider to MultiProvider
  ↓
MainApp builds
  ↓
_checkApiConnectivity() runs
  ↓
ApiService.checkApiConnectivity()
  ↓
If fails → Show DemoModeDialog
  ↓
User confirms → Enable Demo Mode
```

### 2. API Request Flow

```dart
Page needs data
  ↓
Check isDemoMode from DemoModeProvider
  ↓
Call ApiService.get/post/delete with isDemoMode flag
  ↓
If isDemoMode = true:
  - Simulate network delay (500-800ms)
  - Return mock data from MockData class
  ↓
If isDemoMode = false:
  - Make real HTTP request
  - Return actual API response
```

## Usage Examples

### Making API Calls with Demo Mode Support

#### GET Request

```dart
// In your page/widget
final isDemoMode = Provider.of<DemoModeProvider>(context, listen: false).isDemoMode;

// Call the API function with demo mode flag
await getEstablishment(_establishmentStream, isDemoMode: isDemoMode);

// In the API function
Future<void> getEstablishment(
    StreamController<List<EstablishmentModel>> stream,
    {bool isDemoMode = false}) async {
  try {
    final jsonResponse = await ApiService.get(
      'establishment',
      isDemoMode: isDemoMode,
    );
    // Process response...
  } catch (e) {
    stream.add([]);
  }
}
```

#### POST Request

```dart
final isDemoMode = Provider.of<DemoModeProvider>(context, listen: false).isDemoMode;

final jsonResponse = await ApiService.post(
  'announcement',
  {
    'subject': subject,
    'body': body,
  },
  isDemoMode: isDemoMode,
);
```

#### DELETE Request

```dart
final isDemoMode = Provider.of<DemoModeProvider>(context, listen: false).isDemoMode;

final jsonResponse = await ApiService.delete(
  'announcement/$id',
  isDemoMode: isDemoMode,
);
```

## Adding New Mock Data

To add mock data for a new endpoint:

1. Open `lib/src/data/mock/mock_data.dart`
2. Add a new static constant with your mock response:

```dart
static const Map<String, dynamic> yourNewEndpointResponse = {
  "quack": true,
  "message": "Data retrieved successfully",
  "data": [
    {
      "id": 1,
      "field1": "value1",
      "field2": "value2",
      // ... your mock data
    }
  ]
};
```

3. Update the `_getMockData` method in `api_service.dart`:

```dart
static Map<String, dynamic> _getMockData(String endpoint) {
  if (endpoint.contains('establishment')) {
    return MockData.establishmentResponse;
  } else if (endpoint.contains('announcement')) {
    return MockData.announcementResponse;
  } else if (endpoint.contains('your-new-endpoint')) {
    return MockData.yourNewEndpointResponse;
  } else {
    return MockData.errorResponse;
  }
}
```

## Testing Demo Mode

### Method 1: Disable Server

1. Stop your backend API server
2. Run the Flutter app
3. The demo mode dialog should appear automatically

### Method 2: Change API URL

1. Open `lib/src/data/server/url.dart`
2. Change the host to an invalid URL:

```dart
static String host = "http://invalid-url.com/api/";
```

3. Run the app

### Method 3: Manual Trigger

You can manually enable demo mode in code:

```dart
Provider.of<DemoModeProvider>(context, listen: false).enableDemoMode();
```

## Configuration

### Timeout Settings

Adjust the connection timeout in `api_service.dart`:

```dart
static const Duration _connectionTimeout = Duration(seconds: 5);
```

### Mock Data Delay

Adjust the simulated network delay in `api_service.dart`:

```dart
// For GET requests
await Future.delayed(const Duration(milliseconds: 500));

// For POST requests
await Future.delayed(const Duration(milliseconds: 800));

// For DELETE requests
await Future.delayed(const Duration(milliseconds: 600));
```

## Benefits

1. **Better User Experience**: App remains functional even when offline
2. **Development**: Test UI without running backend server
3. **Demos**: Show app functionality without live data
4. **Testing**: Consistent test data for QA
5. **Resilience**: Graceful degradation when API is down

## State Management

The `DemoModeProvider` manages three states:

```dart
bool _isDemoMode = false;              // Is demo mode active?
bool _hasCheckedConnectivity = false;  // Has connectivity been checked?
```

Methods:

- `enableDemoMode()` - Activate demo mode
- `disableDemoMode()` - Deactivate demo mode
- `setConnectivityChecked()` - Mark connectivity as checked
- `reset()` - Reset all states

## Future Enhancements

Potential improvements:

1. Add a manual toggle in settings to switch between modes
2. Implement periodic connectivity checks to auto-exit demo mode
3. Add more detailed mock data scenarios
4. Cache real data and use it in demo mode
5. Add analytics to track demo mode usage
6. Implement partial demo mode (some endpoints real, some mock)

## Troubleshooting

### Dialog doesn't appear

- Check if `_checkApiConnectivity()` is being called in `initState`
- Verify the API URL in `url.dart` is correct
- Check console for connectivity check results

### Mock data not showing

- Verify `isDemoMode` flag is being passed correctly
- Check `_getMockData()` method includes your endpoint
- Ensure mock data structure matches your model

### Banner not visible

- Confirm `DemoModeBanner` is in the widget tree
- Check if `isDemoMode` is true in provider
- Verify Consumer<DemoModeProvider> is wrapping correctly

## API Service Methods

### `checkApiConnectivity()`

Returns `Future<bool>` indicating if API is reachable.

### `get(endpoint, {isDemoMode})`

Performs GET request or returns mock data.

### `post(endpoint, body, {isDemoMode})`

Performs POST request or returns mock success response.

### `delete(endpoint, {isDemoMode})`

Performs DELETE request or returns mock success response.

## Mock Data Structure

All mock responses follow this structure:

```json
{
  "quack": true,
  "message": "Operation message",
  "data": [...]
}
```

This matches your existing API response format.

---

**Note**: Demo mode is designed for development and graceful degradation. For production, ensure proper error handling and user communication about connectivity issues.
