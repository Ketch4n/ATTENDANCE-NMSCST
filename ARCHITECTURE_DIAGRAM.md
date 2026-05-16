# Demo Mode Architecture Diagram

## System Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                         APP STARTUP                              │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                    Initialize Firebase                           │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│              Setup Providers (MultiProvider)                     │
│  • UserSessionEvent                                              │
│  • IndexedStackPagesEvent                                        │
│  • TextfieldBody                                                 │
│  • DemoModeProvider ← NEW                                        │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                    MainApp Widget Builds                         │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│              _checkApiConnectivity() Runs                        │
│              (500ms delay for initialization)                    │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│           ApiService.checkApiConnectivity()                      │
│           (5 second timeout)                                     │
└─────────────────────────────────────────────────────────────────┘
                              ↓
                    ┌─────────┴─────────┐
                    ↓                   ↓
        ┌──────────────────┐  ┌──────────────────┐
        │  API Reachable   │  │ API Unreachable  │
        └──────────────────┘  └──────────────────┘
                    ↓                   ↓
        ┌──────────────────┐  ┌──────────────────┐
        │  Normal Mode     │  │  Show Dialog     │
        │  No Banner       │  │  DemoModeDialog  │
        └──────────────────┘  └──────────────────┘
                                        ↓
                              ┌─────────┴─────────┐
                              ↓                   ↓
                    ┌──────────────────┐  ┌──────────────────┐
                    │  User Confirms   │  │  User Cancels    │
                    │  Enter Demo Mode │  │  Stay Offline    │
                    └──────────────────┘  └──────────────────┘
                              ↓                   ↓
                    ┌──────────────────┐  ┌──────────────────┐
                    │  Demo Mode ON    │  │  No Demo Mode    │
                    │  Show Banner     │  │  No Banner       │
                    └──────────────────┘  └──────────────────┘
```

## API Request Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                    User Action (e.g., Load Data)                 │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│              Page/Widget Needs Data                              │
│              (e.g., EstablishmentPage)                           │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│         Check DemoModeProvider.isDemoMode                        │
│         final isDemoMode = Provider.of<DemoModeProvider>         │
│                           (context, listen: false).isDemoMode    │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│         Call API Function with isDemoMode Flag                   │
│         await getEstablishment(stream, isDemoMode: isDemoMode)   │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│              ApiService.get/post/delete()                        │
│              (endpoint, isDemoMode: isDemoMode)                  │
└─────────────────────────────────────────────────────────────────┘
                              ↓
                    ┌─────────┴─────────┐
                    ↓                   ↓
        ┌──────────────────┐  ┌──────────────────┐
        │ isDemoMode=false │  │ isDemoMode=true  │
        └──────────────────┘  └──────────────────┘
                    ↓                   ↓
        ┌──────────────────┐  ┌──────────────────┐
        │  Real HTTP Call  │  │  Simulate Delay  │
        │  http.get/post   │  │  (500-800ms)     │
        └──────────────────┘  └──────────────────┘
                    ↓                   ↓
        ┌──────────────────┐  ┌──────────────────┐
        │  Parse Response  │  │  Return Mock     │
        │  json.decode()   │  │  MockData.xxx    │
        └──────────────────┘  └──────────────────┘
                    ↓                   ↓
                    └─────────┬─────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│              Return Map<String, dynamic>                         │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│              Parse to Model Objects                              │
│              (EstablishmentModel, AnnouncementModel)             │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│              Update Stream/UI                                    │
│              stream.add(data)                                    │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│              Display Data to User                                │
└─────────────────────────────────────────────────────────────────┘
```

## Component Relationships

```
┌─────────────────────────────────────────────────────────────────┐
│                          main.dart                               │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │                    MultiProvider                            │ │
│  │  ┌──────────────────────────────────────────────────────┐  │ │
│  │  │            DemoModeProvider                          │  │ │
│  │  │  • isDemoMode: bool                                  │  │ │
│  │  │  • hasCheckedConnectivity: bool                      │  │ │
│  │  │  • enableDemoMode()                                  │  │ │
│  │  │  • disableDemoMode()                                 │  │ │
│  │  └──────────────────────────────────────────────────────┘  │ │
│  └────────────────────────────────────────────────────────────┘ │
│                                                                   │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │                    MainApp Widget                           │ │
│  │  • _checkApiConnectivity()                                 │ │
│  │  • Consumer<DemoModeProvider>                              │ │
│  └────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
                              ↓
        ┌─────────────────────┴─────────────────────┐
        ↓                                           ↓
┌──────────────────┐                      ┌──────────────────┐
│ DemoModeBanner   │                      │ DemoModeDialog   │
│ (Visual)         │                      │ (Confirmation)   │
└──────────────────┘                      └──────────────────┘
        ↓                                           ↓
┌──────────────────────────────────────────────────────────────┐
│                      ApiService                               │
│  ┌────────────────────────────────────────────────────────┐  │
│  │  checkApiConnectivity() → bool                         │  │
│  │  get(endpoint, isDemoMode) → Map                       │  │
│  │  post(endpoint, body, isDemoMode) → Map                │  │
│  │  delete(endpoint, isDemoMode) → Map                    │  │
│  │  _getMockData(endpoint) → Map                          │  │
│  └────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────┘
                              ↓
        ┌─────────────────────┴─────────────────────┐
        ↓                                           ↓
┌──────────────────┐                      ┌──────────────────┐
│   MockData       │                      │   http package   │
│   (Static Data)  │                      │   (Real API)     │
└──────────────────┘                      └──────────────────┘
        ↓                                           ↓
┌──────────────────────────────────────────────────────────────┐
│              API Functions (get.dart, post.dart, etc.)        │
│  • getEstablishment(stream, isDemoMode)                       │
│  • getAnnouncement(stream, isDemoMode)                        │
│  • postEstablishment(context, data, isDemoMode)               │
│  • deleteAnnouncement(context, id, isDemoMode)                │
└──────────────────────────────────────────────────────────────┘
                              ↓
┌──────────────────────────────────────────────────────────────┐
│                    Pages/Widgets                              │
│  • EstablishmentPage                                          │
│  • AnnouncementPage                                           │
│  • DashboardPage                                              │
└──────────────────────────────────────────────────────────────┘
```

## Data Flow Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                         USER INTERFACE                           │
│  ┌────────────────┐  ┌────────────────┐  ┌────────────────┐    │
│  │  Dashboard     │  │ Establishment  │  │ Announcement   │    │
│  │  Page          │  │ Page           │  │ Page           │    │
│  └────────────────┘  └────────────────┘  └────────────────┘    │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                      STATE MANAGEMENT                            │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │              DemoModeProvider (ChangeNotifier)             │ │
│  │  • Manages demo mode state                                 │ │
│  │  • Notifies listeners on changes                           │ │
│  └────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                       SERVICE LAYER                              │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │                    ApiService                              │ │
│  │  • Routes requests based on demo mode                      │ │
│  │  • Handles timeouts and errors                             │ │
│  │  • Provides unified interface                              │ │
│  └────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
                              ↓
                    ┌─────────┴─────────┐
                    ↓                   ↓
┌──────────────────────────┐  ┌──────────────────────────┐
│      MOCK DATA           │  │      REAL API            │
│  ┌────────────────────┐  │  │  ┌────────────────────┐  │
│  │  MockData Class    │  │  │  │  HTTP Requests     │  │
│  │  • Establishments  │  │  │  │  • GET /api/...    │  │
│  │  • Announcements   │  │  │  │  • POST /api/...   │  │
│  │  • Success/Error   │  │  │  │  • DELETE /api/... │  │
│  └────────────────────┘  │  │  └────────────────────┘  │
└──────────────────────────┘  └──────────────────────────┘
                    ↓                   ↓
                    └─────────┬─────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                       DATA MODELS                                │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │  • EstablishmentModel                                      │ │
│  │  • AnnouncementModel                                       │ │
│  │  • fromJson() constructors                                 │ │
│  └────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                    STREAM CONTROLLERS                            │
│  • StreamController<List<EstablishmentModel>>                   │
│  • StreamController<List<AnnouncementModel>>                    │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                      STREAM BUILDERS                             │
│  • Listen to streams                                             │
│  • Rebuild UI on data changes                                    │
│  • Handle loading/error states                                   │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                    RENDERED UI                                   │
│  • DataTables, ListViews, Cards                                  │
│  • Demo Mode Banner (if active)                                  │
└─────────────────────────────────────────────────────────────────┘
```

## File Dependencies

```
main.dart
├── DemoModeProvider (provider)
├── DemoModeBanner (component)
├── DemoModeDialog (component)
└── ApiService (service)

ApiService
├── MockData (mock)
├── Servername (server/url)
└── http package

DemoModeDialog
└── DemoModeProvider (provider)

Pages (Establishment, Announcement)
├── DemoModeProvider (provider)
├── ApiService (via functions)
└── Models (EstablishmentModel, AnnouncementModel)

API Functions (get.dart, post.dart, delete.dart)
├── ApiService (service)
└── Models
```

## State Transitions

```
┌─────────────────┐
│  Initial State  │
│  isDemoMode:    │
│    false        │
│  hasChecked:    │
│    false        │
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│ Check API       │
│ Connectivity    │
└────────┬────────┘
         │
    ┌────┴────┐
    ↓         ↓
┌────────┐ ┌────────┐
│Success │ │ Failed │
└───┬────┘ └───┬────┘
    │          │
    ↓          ↓
┌────────┐ ┌────────┐
│Normal  │ │ Show   │
│Mode    │ │ Dialog │
└────────┘ └───┬────┘
               │
          ┌────┴────┐
          ↓         ↓
      ┌────────┐ ┌────────┐
      │Confirm │ │Cancel  │
      └───┬────┘ └───┬────┘
          │          │
          ↓          ↓
      ┌────────┐ ┌────────┐
      │Demo    │ │Normal  │
      │Mode ON │ │Mode    │
      │isDemoMode│hasChecked│
      │  true  │ │  true  │
      └────────┘ └────────┘
```

---

## Key Design Decisions

### 1. **Provider Pattern**

- Centralized state management
- Easy access from any widget
- Automatic UI updates via notifyListeners()

### 2. **Service Layer**

- Single point of API interaction
- Consistent error handling
- Easy to test and maintain

### 3. **Mock Data Separation**

- Isolated in dedicated file
- Easy to update and extend
- Matches real API structure

### 4. **User Confirmation**

- Non-intrusive dialog
- Clear explanation
- User has control

### 5. **Visual Feedback**

- Persistent banner
- Clear indication of mode
- Professional appearance

---

This architecture ensures:

- ✅ Separation of concerns
- ✅ Maintainability
- ✅ Testability
- ✅ Scalability
- ✅ User experience
