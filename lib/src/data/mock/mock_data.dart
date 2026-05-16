class MockData {
  // Mock Establishment Data
  static const Map<String, dynamic> establishmentResponse = {
    "quack": true,
    "message": "Establishments retrieved successfully",
    "data": [
      {
        "id": 1,
        "establishment_name": "Main Campus",
        "latitude": "14.5995",
        "longitude": "120.9842",
        "location": "Manila, Philippines",
        "hours_required": "8",
        "radius": "100",
        "status": 1,
        "created_at": "2024-01-15T08:00:00.000000Z",
        "updated_at": "2024-01-15T08:00:00.000000Z"
      },
      {
        "id": 2,
        "establishment_name": "North Campus",
        "latitude": "14.6091",
        "longitude": "121.0223",
        "location": "Quezon City, Philippines",
        "hours_required": "8",
        "radius": "150",
        "status": 1,
        "created_at": "2024-01-20T09:30:00.000000Z",
        "updated_at": "2024-01-20T09:30:00.000000Z"
      },
      {
        "id": 3,
        "establishment_name": "South Campus",
        "latitude": "14.5547",
        "longitude": "121.0244",
        "location": "Makati, Philippines",
        "hours_required": "8",
        "radius": "120",
        "status": 1,
        "created_at": "2024-02-01T10:00:00.000000Z",
        "updated_at": "2024-02-01T10:00:00.000000Z"
      },
      {
        "id": 4,
        "establishment_name": "East Campus",
        "latitude": "14.5764",
        "longitude": "121.0851",
        "location": "Pasig, Philippines",
        "hours_required": "8",
        "radius": "130",
        "status": 1,
        "created_at": "2024-02-10T11:15:00.000000Z",
        "updated_at": "2024-02-10T11:15:00.000000Z"
      },
      {
        "id": 5,
        "establishment_name": "West Campus",
        "latitude": "14.5378",
        "longitude": "120.9896",
        "location": "Parañaque, Philippines",
        "hours_required": "8",
        "radius": "110",
        "status": 0,
        "created_at": "2024-02-15T13:45:00.000000Z",
        "updated_at": "2024-02-15T13:45:00.000000Z"
      }
    ]
  };

  // Mock Announcement Data
  static const Map<String, dynamic> announcementResponse = {
    "quack": true,
    "message": "Announcements retrieved successfully",
    "data": [
      {
        "id": 1,
        "subject": "Welcome to the New Semester",
        "body":
            "We are excited to welcome all students and faculty to the new academic semester.<br>Please review the updated guidelines and schedules.",
        "created_at": "2024-03-01T08:00:00.000000Z",
        "updated_at": "2024-03-01T08:00:00.000000Z"
      },
      {
        "id": 2,
        "subject": "System Maintenance Notice",
        "body":
            "The attendance system will undergo maintenance on March 15, 2024.<br>Expected downtime: 2 hours (10:00 PM - 12:00 AM).",
        "created_at": "2024-03-05T14:30:00.000000Z",
        "updated_at": "2024-03-05T14:30:00.000000Z"
      },
      {
        "id": 3,
        "subject": "Holiday Schedule Update",
        "body":
            "Please note the updated holiday schedule for this month.<br>March 25 - Regular Holiday<br>March 29 - Special Non-Working Day",
        "created_at": "2024-03-10T09:15:00.000000Z",
        "updated_at": "2024-03-10T09:15:00.000000Z"
      },
      {
        "id": 4,
        "subject": "New Attendance Policy",
        "body":
            "A new attendance policy has been implemented effective immediately.<br>All staff must clock in within the designated radius of their assigned establishment.",
        "created_at": "2024-03-12T11:00:00.000000Z",
        "updated_at": "2024-03-12T11:00:00.000000Z"
      },
      {
        "id": 5,
        "subject": "Training Workshop Announcement",
        "body":
            "Join us for a comprehensive training workshop on the new attendance system.<br>Date: March 20, 2024<br>Time: 2:00 PM - 5:00 PM<br>Venue: Main Campus Auditorium",
        "created_at": "2024-03-14T16:45:00.000000Z",
        "updated_at": "2024-03-14T16:45:00.000000Z"
      }
    ]
  };

  // Mock Success Response for POST requests
  static const Map<String, dynamic> postSuccessResponse = {
    "quack": true,
    "message": "Operation completed successfully (Demo Mode)",
  };

  // Mock Error Response
  static const Map<String, dynamic> errorResponse = {
    "quack": false,
    "message": "An error occurred (Demo Mode)",
  };
}
