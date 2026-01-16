# Login & Signup Flow Implementation

## Overview
Implemented a complete login and signup flow based on API documentation with support for three user permission levels and distinct registration paths.

## Architecture
- **CUBITs**: Separate cubits for Login, Clinic Registration, and Doctor Registration
- **Repositories**: Dedicated repos for each authentication type
- **States**: Freezed immutable states for type safety
- **BlocListeners**: Automatic navigation and error handling
- **API Services**: Retrofit-based HTTP client with generated code

## Permission System

### Permission Levels
- **Permission 0**: Patient/Public user (limited access) → `PatientScreen`
- **Permission 1**: Therapist (moderate access) → `TherapistScreen`  
- **Permission >= 2**: Administrator/Secretary (full access) → `ClinicAdminScreen`

## User Flows

### 1. Login Flow
**Endpoint**: `POST /api/login`

```dart
LoginCubit → LoginRepo → ApiService.login()
    ↓
LoginBlocListener
    ↓
(Permission Check) → Route to appropriate screen
```

**Login with any permission level**:
- Username/Password authentication
- Returns JWT token + permission level
- Automatic route to user's dashboard based on permission

### 2. Clinic Registration (New Clinic)
**Endpoint**: `POST /api/register/ClinicGroup`

```dart
RegisterCubit → RegisterRepo → ApiService.register()
    ↓
RegisterBlocListener
    ↓
Success → Navigate to Login
```

**Create new clinic group with admin**:
- Clinic Name (as "name" field)
- Admin Password
- Returns: `{"data": "validated"}`

### 3. Doctor Registration (Join Existing Clinic)
**Endpoint**: `POST /api/register`

```dart
DoctorRegisterCubit → DoctorRegisterRepo → ApiService.registerDoctor()
    ↓
DoctorRegisterBlocListener
    ↓
Success → Navigate to Login
```

**Register as doctor to existing clinic**:
- Username
- Password
- Permission (1 for Therapist)
- Clinic Group ID
- Returns: `{"message": "..."}`

## File Structure

### API Integration
- `lib/core/networks/api_constatns.dart` - API endpoints
- `lib/core/networks/api_services.dart` - Retrofit client
- `lib/core/di/dependency_injection.dart` - DI setup

### Login Feature
- `lib/features/login/logic/cubit/login_cubit.dart`
- `lib/features/login/data/repos/login_repo.dart`
- `lib/features/login/data/models/` - LoginRequestBody, LoginResponse
- `lib/features/login/UI/widgets/login_bloc_listener.dart`

### Clinic Registration
- `lib/features/register/logic/cubit/register_cubit.dart`
- `lib/features/register/data/repos/register_repo.dart`
- `lib/features/register/data/models/register_request_body.dart`, `register_response.dart`
- `lib/features/register/UI/widgets/register_bloc_listener.dart`

### Doctor Registration
- `lib/features/register/logic/cubit/doctor_register_cubit.dart`
- `lib/features/register/data/repos/doctor_register_repo.dart`
- `lib/features/register/data/models/doctor_register_request_body.dart`, `doctor_register_response.dart`
- `lib/features/register/UI/widgets/doctor_register_bloc_listener.dart`

### User Dashboards (Empty Screens Ready for UI)
- `lib/features/patient/UI/patient_screen.dart` - Permission 0
- `lib/features/therapist/UI/therapist_screen.dart` - Permission 1
- `lib/features/clinic_admin/UI/clinic_admin_screen.dart` - Permission >= 2

## API Endpoints Used

| Endpoint | Method | Purpose | Request | Response |
|----------|--------|---------|---------|----------|
| `/api/login` | POST | User authentication | `{username, password}` | `{jwt, message, permission}` |
| `/api/register/ClinicGroup` | POST | Create new clinic | `{name, password}` | `{data: "validated"}` |
| `/api/register` | POST | Register doctor | `{username, password, permission, clinic_group_id}` | `{message}` |

## State Management Flow

### Login Success
```
LoginBlocListener listens to LoginCubit state
    ↓
On Success:
  1. Save JWT token to SharedPreferences
  2. Set token in Dio headers
  3. Check permission level
  4. Navigate to appropriate dashboard
```

### Registration Success
```
RegisterBlocListener / DoctorRegisterBlocListener listens
    ↓
On Success:
  1. Show success snackbar
  2. Navigate to LoginScreen
    ↓
User can now login with new credentials
```

## Error Handling
- API errors caught and converted to `ApiErrorModel`
- Error messages displayed via `SnackBar`
- Loading state shows circular progress dialog
- Auto-dismiss loading dialog on success/failure

## Next Steps for UI
The three dashboard screens are empty and ready for custom UI implementation:
- `PatientScreen`: Build patient appointment/medical records UI
- `TherapistScreen`: Build therapist schedule/appointments/sales UI  
- `ClinicAdminScreen`: Build admin dashboard for doctor/client management

All backend logic is complete and functional!
