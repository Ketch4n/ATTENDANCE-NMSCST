# Testing Checklist - Demo Mode Feature

## Pre-Testing Setup

- [ ] Run `flutter pub get` to ensure all dependencies are installed
- [ ] Verify your backend API server URL in `lib/src/data/server/url.dart`
- [ ] Have access to start/stop your backend server

---

## Test 1: Demo Mode Activation (API Offline)

### Setup

- [ ] Stop your backend API server
- [ ] Clear app data/cache (optional)

### Steps

1. [ ] Run the app: `flutter run -d chrome`
2. [ ] Wait for app to initialize (~500ms)
3. [ ] Observe the demo mode dialog appears

### Expected Results

- [ ] Dialog shows with title "API Connection Failed"
- [ ] Dialog explains connection failure reasons
- [ ] Dialog has "Cancel" and "Enter Demo Mode" buttons
- [ ] Dialog is not dismissible by clicking outside

### Actions

4. [ ] Click "Enter Demo Mode"

### Expected Results

- [ ] Dialog closes
- [ ] Orange banner appears at top: "DEMO MODE - Using Sample Data"
- [ ] Banner shows "OFFLINE" badge
- [ ] App loads successfully

---

## Test 2: Demo Mode Data Display

### Establishment Page

- [ ] Navigate to Establishment page
- [ ] Verify 5 establishments are displayed:
  - [ ] Main Campus (Manila)
  - [ ] North Campus (Quezon City)
  - [ ] South Campus (Makati)
  - [ ] East Campus (Pasig)
  - [ ] West Campus (Parañaque)
- [ ] Check all fields display correctly (name, location, radius, etc.)
- [ ] Verify data loads with slight delay (~500ms)

### Announcement Page

- [ ] Navigate to Announcement page
- [ ] Verify 5 announcements are displayed:
  - [ ] Welcome to the New Semester
  - [ ] System Maintenance Notice
  - [ ] Holiday Schedule Update
  - [ ] New Attendance Policy
  - [ ] Training Workshop Announcement
- [ ] Check all fields display correctly (subject, body, date)
- [ ] Verify data loads with slight delay (~500ms)

### Dashboard Page

- [ ] Navigate to Dashboard page
- [ ] Verify page loads without errors
- [ ] Check if any dashboard widgets display correctly

---

## Test 3: Demo Mode Operations

### Create Operation (POST)

- [ ] Navigate to Announcement page
- [ ] Click "Add New" button
- [ ] Fill in form:
  - Subject: "Test Announcement"
  - Body: "This is a test"
- [ ] Submit form

### Expected Results

- [ ] Loading indicator appears
- [ ] Success message shows: "Operation completed successfully (Demo Mode)"
- [ ] Form closes
- [ ] Note: New item won't appear in list (mock data is static)

### Delete Operation (DELETE)

- [ ] Navigate to Announcement page
- [ ] Click delete icon on any announcement
- [ ] Confirm deletion

### Expected Results

- [ ] Confirmation dialog appears
- [ ] After confirming, loading indicator shows
- [ ] Success message appears
- [ ] Note: Item won't actually be removed (mock data is static)

---

## Test 4: Normal Mode (API Online)

### Setup

- [ ] Start your backend API server
- [ ] Ensure server is accessible at configured URL
- [ ] Close the app completely

### Steps

1. [ ] Run the app: `flutter run -d chrome`
2. [ ] Wait for app to initialize

### Expected Results

- [ ] No demo mode dialog appears
- [ ] No orange banner at top
- [ ] App connects to real API
- [ ] Real data loads from database

### Verify Real Data

- [ ] Navigate to Establishment page
- [ ] Verify real establishments from database are shown
- [ ] Navigate to Announcement page
- [ ] Verify real announcements from database are shown

### Verify Real Operations

- [ ] Create a new announcement
- [ ] Verify it appears in the list
- [ ] Delete an announcement
- [ ] Verify it's removed from the list

---

## Test 5: Dialog Cancel Action

### Setup

- [ ] Stop your backend API server
- [ ] Close the app completely

### Steps

1. [ ] Run the app: `flutter run -d chrome`
2. [ ] Wait for demo mode dialog to appear
3. [ ] Click "Cancel" button

### Expected Results

- [ ] Dialog closes
- [ ] No orange banner appears
- [ ] App continues without demo mode
- [ ] Pages may show empty data or errors (expected)

---

## Test 6: Banner Visibility

### In Demo Mode

- [ ] Ensure app is in demo mode (orange banner visible)
- [ ] Navigate to Dashboard page
- [ ] Verify banner is still visible
- [ ] Navigate to Establishment page
- [ ] Verify banner is still visible
- [ ] Navigate to Announcement page
- [ ] Verify banner is still visible

### Expected Results

- [ ] Banner persists across all pages
- [ ] Banner stays at the top of the screen
- [ ] Banner doesn't interfere with page content

---

## Test 7: Network Delay Simulation

### In Demo Mode

- [ ] Navigate to Establishment page
- [ ] Observe loading indicator
- [ ] Time the delay (should be ~500ms)
- [ ] Navigate to Announcement page
- [ ] Observe loading indicator
- [ ] Time the delay (should be ~500ms)

### Expected Results

- [ ] Loading indicators appear briefly
- [ ] Delays feel natural (not instant, not too slow)
- [ ] Data appears after delay

---

## Test 8: Error Handling

### Invalid Endpoint (Demo Mode)

This test requires code modification:

- [ ] Temporarily modify an API call to use invalid endpoint
- [ ] Verify error is handled gracefully
- [ ] Restore original endpoint

### Network Timeout (Normal Mode)

- [ ] Start backend server
- [ ] Run app in normal mode
- [ ] Stop backend server while app is running
- [ ] Try to load data
- [ ] Verify error handling

---

## Test 9: State Persistence

### Demo Mode State

- [ ] Enter demo mode
- [ ] Navigate between pages
- [ ] Verify demo mode persists
- [ ] Check banner remains visible

### After App Restart

- [ ] Close app while in demo mode
- [ ] Restart app with server still offline
- [ ] Verify dialog appears again (state doesn't persist across restarts)

---

## Test 10: UI/UX Quality

### Dialog Design

- [ ] Dialog is centered on screen
- [ ] Text is readable and clear
- [ ] Icons are appropriate
- [ ] Buttons are clearly labeled
- [ ] Colors are professional

### Banner Design

- [ ] Banner is prominent but not intrusive
- [ ] Orange color is appropriate for warning
- [ ] Text is readable on orange background
- [ ] "OFFLINE" badge is visible
- [ ] Banner doesn't cover important content

### Overall Experience

- [ ] Transitions are smooth
- [ ] No flickering or visual glitches
- [ ] Loading states are clear
- [ ] Success/error messages are appropriate

---

## Test 11: Mobile Responsiveness (Optional)

If testing on mobile devices:

- [ ] Run app on Android emulator/device
- [ ] Verify dialog displays correctly
- [ ] Verify banner displays correctly
- [ ] Test all functionality
- [ ] Run app on iOS simulator/device
- [ ] Verify dialog displays correctly
- [ ] Verify banner displays correctly
- [ ] Test all functionality

---

## Test 12: Performance

### Memory Usage

- [ ] Monitor memory usage in demo mode
- [ ] Navigate between pages multiple times
- [ ] Verify no memory leaks

### Load Times

- [ ] Measure initial app load time
- [ ] Measure page navigation times
- [ ] Compare demo mode vs normal mode
- [ ] Verify acceptable performance

---

## Test 13: Edge Cases

### Rapid Navigation

- [ ] Enter demo mode
- [ ] Rapidly navigate between pages
- [ ] Verify no crashes or errors

### Multiple Operations

- [ ] Try to create multiple announcements quickly
- [ ] Verify all operations complete
- [ ] Check for any race conditions

### Long Text

- [ ] Create announcement with very long subject
- [ ] Create announcement with very long body
- [ ] Verify UI handles long text appropriately

---

## Test 14: Code Quality

### Static Analysis

- [ ] Run `flutter analyze lib/`
- [ ] Verify no critical issues
- [ ] Address any warnings

### Diagnostics

- [ ] Run `flutter pub run dart analyze`
- [ ] Check for type errors
- [ ] Verify null safety

---

## Test 15: Documentation

### Code Comments

- [ ] Review new files for adequate comments
- [ ] Verify complex logic is explained
- [ ] Check for TODO items

### External Documentation

- [ ] Read QUICK_START.md
- [ ] Follow instructions
- [ ] Verify accuracy
- [ ] Read DEMO_MODE_GUIDE.md
- [ ] Verify completeness
- [ ] Check for clarity

---

## Regression Testing

### Existing Features

- [ ] Login/Authentication still works
- [ ] User session management works
- [ ] Firebase integration works
- [ ] All existing pages load correctly
- [ ] No existing functionality is broken

---

## Final Checklist

- [ ] All tests passed
- [ ] No critical bugs found
- [ ] Performance is acceptable
- [ ] UI/UX is polished
- [ ] Documentation is complete
- [ ] Code is clean and maintainable

---

## Issues Found

Document any issues found during testing:

| Test # | Issue Description | Severity | Status |
| ------ | ----------------- | -------- | ------ |
|        |                   |          |        |
|        |                   |          |        |
|        |                   |          |        |

---

## Sign-Off

- [ ] All critical tests passed
- [ ] All high-priority tests passed
- [ ] Documentation reviewed
- [ ] Ready for production

**Tested By:** ********\_\_\_********  
**Date:** ********\_\_\_********  
**Signature:** ********\_\_\_********

---

## Notes

Add any additional notes or observations:

```
[Your notes here]
```
