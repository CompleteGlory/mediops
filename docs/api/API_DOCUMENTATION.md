# PhysioUp API Documentation

## Overview
PhysioUp is a physiotherapy clinic management system built with Go (Gin framework) and PostgreSQL. The API provides endpoints for appointment management, patient records, therapist scheduling, treatment packages, and referral management.

---

## Authentication & Permission System

### Permission Levels
- **Permission 0**: Patient/Public user (limited access)
- **Permission 1**: Therapist (moderate access)
- **Permission >= 2**: Administrator/Secretary (full access)

### Authentication Flow
1. **Login**: User provides username/password → JWT token returned
2. **JWT Validation**: All protected routes use `JwtAuthMiddleware()`
3. **Clinic Group Filtering**: `SetClinicGroup()` middleware automatically filters all data by `clinic_group_id`
4. **Permission Check**: `PermissionCheckAdmin()` enforces admin-only access

### Key Middleware
```go
// JwtAuthMiddleware - Validates JWT token
JwtAuthMiddleware() → Checks token validity

// SetClinicGroup - Filters all queries by clinic group
SetClinicGroup() → Scopes all DB queries to user's clinic_group_id

// PermissionCheckAdmin - Enforces permission >= 2
PermissionCheckAdmin() → Returns 400 if permission < 2
```

**Data Isolation**: All tables include `clinic_group_id` field. Queries are automatically scoped to the authenticated user's clinic group.

---

## API Endpoints

### 🔓 PUBLIC ROUTES (No Authentication Required)

#### 1. **POST** `/api/login`
Authenticate user and receive JWT token.

**Request:**
```json
{
  "username": "therapist@clinic.com",
  "password": "secure_password"
}
```

**Response (200 OK):**
```json
{
  "message": "Login Successful",
  "jwt": "eyJhbGciOiJIUzI1NiIs...",
  "permission": 1
}
```

**Error Response (400):**
```json
{
  "message": "username or password is incorrect."
}
```

---

#### 2. **POST** `/api/register`
Register a new user account.

**Request:**
```json
{
  "username": "newtherapist@clinic.com",
  "password": "secure_password",
  "permission": 1,
  "clinic_group_id": 1
}
```

**Response (200 OK):**
```json
{
  "data": "validated"
}
```

---

#### 3. **POST** `/api/register/ClinicGroup`
Register a new clinic group with admin user.

**Request:**
```json
{
  "group_name": "Clinic Name",
  "admin_username": "admin@clinic.com",
  "admin_password": "secure_password"
}
```

---

#### 4. **POST** `/api/RequestAppointment`
Request an appointment (by phone number).

**Request:**
```json
{
  "therapist_id": 1,
  "therapist_name": "Dr. Ahmed",
  "patient_name": "John Doe",
  "patient_id": 0,
  "phone_number": "1234567890",
  "date_time": "2026/01/15 & 03:00 PM",
  "is_existing": false,
  "super_treatment_plan_description": "General Physiotherapy"
}
```

**Response (200 OK):**
```json
{
  "message": "Appointment request created",
  "appointment_request_id": 5
}
```

**Business Rules:**
- If `patient_id = 0` and `is_existing = false`: Create new patient
- If `patient_id = 0` and `is_existing = true`: Phone number must exist
- Non-admin users cannot book > 14 days in advance
- Time block must be available in therapist's schedule

---

#### 5. **POST** `/api/GetPatientIdByPhone`
Get patient ID from phone number.

**Request:**
```json
{
  "phone_number": "1234567890"
}
```

**Response (200 OK):**
```json
{
  "patient_id": 3,
  "patient_name": "John Doe"
}
```

---

#### 6. **POST** `/api/FetchAppointmentsByPatientID`
Get all appointments for a patient.

**Request:**
```json
{
  "patient_id": 3
}
```

**Response (200 OK):**
```json
[
  {
    "id": 1,
    "date_time": "2026/01/20 & 03:00 PM",
    "therapist_id": 1,
    "therapist_name": "Dr. Ahmed",
    "patient_name": "John Doe",
    "patient_id": 3,
    "price": 150.00,
    "is_completed": false,
    "is_paid": false,
    "payment_method": "cash",
    "notes": "Knee pain treatment",
    "treatment_plan_id": 1,
    "reminder_sent": true
  }
]
```

---

#### 7. **POST** `/api/FetchFutureAppointments`
Get future appointments for a patient.

**Request:**
```json
{
  "patient_id": 3
}
```

**Response:** Same as FetchAppointmentsByPatientID

---

#### 8. **POST** `/api/VerifyAppointmentRequestPhoneNo`
Verify phone number for appointment request.

**Request:**
```json
{
  "phone_number": "1234567890"
}
```

**Response (200 OK):**
```json
{
  "message": "Phone verified"
}
```

---

#### 9. **GET** `/api/GetTherapistsTrimmed`
Get list of therapists (name, ID, photo only).

**Response (200 OK):**
```json
[
  {
    "id": 1,
    "name": "Dr. Ahmed Ibrahim",
    "photo_url": "https://cdn.example.com/photo1.jpg",
    "is_demo": false
  },
  {
    "id": 2,
    "name": "Dr. Fatima Hassan",
    "photo_url": "https://cdn.example.com/photo2.jpg",
    "is_demo": false
  }
]
```

---

### 🔒 PROTECTED ROUTES (Require JWT + Clinic Group Scoping)

#### 10. **GET** `/api/protected/user`
Get current authenticated user info.

**Response (200 OK):**
```json
{
  "message": "success",
  "data": {
    "ID": 5,
    "username": "therapist@clinic.com",
    "clinic_name": "Premier Clinic",
    "permission": 1,
    "clinic_group_id": 1
  }
}
```

---

#### 11. **POST** `/api/protected/SaveFCM`
Save Firebase Cloud Messaging token for push notifications.

**Request:**
```json
{
  "token": "eO5V3z8nL2K..."
}
```

**Response (200 OK):**
```json
null
```

---

### 👥 USER & THERAPIST MANAGEMENT

#### 12. **POST** `/api/protected/RegisterTherapist`
Register a new therapist (Admin only).

**Request:**
```json
{
  "name": "Dr. Mohammed Ali",
  "user_id": 10,
  "phone": "1234567890",
  "photo_url": "https://cdn.example.com/therapist.jpg",
  "is_demo": false
}
```

**Response (200 OK):**
```json
{
  "message": "Therapist Created Successfully",
  "id": 5
}
```

---

#### 13. **POST** `/api/protected/DeleteTherapist`
Delete a therapist (Admin only).

**Request:**
```json
{
  "therapist_id": 5
}
```

**Response (200 OK):**
```json
{
  "message": "Therapist Deleted Successfully"
}
```

---

#### 14. **GET** `/api/protected/GetTherapists`
Get all therapists in clinic group.

**Response (200 OK):**
```json
[
  {
    "id": 1,
    "name": "Dr. Ahmed Ibrahim",
    "user_id": 3,
    "phone": "1234567890",
    "schedule": {
      "id": 1,
      "therapist_id": 1,
      "time_blocks": [...]
    },
    "photo_url": "https://...",
    "is_demo": false
  }
]
```

---

#### 15. **POST** `/api/protected/GetTherapistSchedule`
Get therapist's schedule for a date range.

**Request:**
```json
{
  "start_date": "2026/01/01",
  "end_date": "2026/01/31"
}
```

**Response (200 OK):**
```json
{
  "id": 1,
  "name": "Dr. Ahmed",
  "user_id": 3,
  "phone": "1234567890",
  "schedule": {
    "id": 1,
    "therapist_id": 1,
    "time_blocks": [
      {
        "id": 1,
        "schedule_id": 1,
        "date": "2026/01/20 & 03:00 PM",
        "is_available": false,
        "appointment": {
          "id": 1,
          "date_time": "2026/01/20 & 03:00 PM",
          "therapist_id": 1,
          "patient_name": "John Doe",
          "patient_id": 3,
          "price": 150.00,
          "is_completed": false,
          "is_paid": false
        }
      }
    ]
  }
}
```

---

#### 16. **POST** `/api/protected/AddTherapistTimeBlocks`
Add available time slots for therapist.

**Request:**
```json
{
  "date_times": [
    "2026/01/20 & 03:00 PM",
    "2026/01/20 & 04:00 PM",
    "2026/01/21 & 10:00 AM"
  ]
}
```

**Response (200 OK):**
```json
{
  "message": "Time blocks added successfully"
}
```

---

### 📅 APPOINTMENT MANAGEMENT

#### 17. **GET** `/api/protected/FetchRequestedAppointments`
Get pending appointment requests.

**Response (200 OK):**
```json
[
  {
    "id": 5,
    "date_time": "2026/01/25 & 02:00 PM",
    "therapist_id": 1,
    "therapist_name": "Dr. Ahmed",
    "patient_name": "Jane Smith",
    "patient_id": 4,
    "phone_number": "9876543210",
    "super_treatment_plan_description": "Post-injury recovery",
    "clinic_group_id": 1
  }
]
```

---

#### 18. **GET** `/api/protected/FetchUnassignedAppointments`
Get appointments not yet linked to treatment plans.

**Response:** Similar structure to FetchRequestedAppointments

---

#### 19. **POST** `/api/protected/AcceptAppointment`
Accept a pending appointment request (creates appointment).

**Request:**
```json
{
  "appointment_request_id": 5,
  "extra": {
    "date_time": "2026/01/25 & 02:00 PM",
    "therapist_id": 1,
    "therapist_name": "Dr. Ahmed",
    "patient_name": "Jane Smith",
    "patient_id": 4,
    "price": 150.00,
    "is_completed": false,
    "is_paid": false,
    "payment_method": "cash",
    "notes": "Post-injury recovery"
  }
}
```

**Response (200 OK):**
```json
{
  "message": "Appointment registered successfully"
}
```

**Side Effects:**
- Time block is created/updated
- Appointment request is deleted
- Firebase notification sent to clinic group
- WhatsApp reminder message sent (if configured)

---

#### 20. **POST** `/api/protected/RegisterAppointment`
Manually create an appointment (without request).

**Request:** Same as AcceptAppointment.extra

**Response (200 OK):**
```json
{
  "message": "Appointment created successfully"
}
```

---

#### 21. **POST** `/api/protected/RejectAppointment`
Reject an appointment request.

**Request:**
```json
{
  "appointment_request_id": 5
}
```

**Response (200 OK):**
```json
{
  "message": "Appointment request rejected"
}
```

---

#### 22. **POST** `/api/protected/MarkAppointmentAsCompleted`
Mark appointment as completed.

**Request:**
```json
{
  "appointment_id": 1
}
```

**Response (200 OK):**
```json
{
  "message": "Appointment marked as completed"
}
```

---

#### 23. **POST** `/api/protected/UnmarkAppointmentAsCompleted`
Unmark appointment as completed.

**Request:**
```json
{
  "appointment_id": 1
}
```

**Response (200 OK):**
```json
{
  "message": "Appointment unmarked as completed"
}
```

---

#### 24. **POST** `/api/protected/RemoveAppointmentSendMessage`
Remove appointment and send cancellation message.

**Request:**
```json
{
  "appointment_id": 1,
  "send_message": true
}
```

**Response (200 OK):**
```json
{
  "message": "Appointment removed"
}
```

---

### 👤 PATIENT MANAGEMENT

#### 25. **GET** `/api/protected/FetchPatients`
Get all patients in clinic group.

**Response (200 OK):**
```json
[
  {
    "id": 3,
    "name": "John Doe",
    "phone": "+201234567890",
    "gender": "Male",
    "age": 35,
    "weight": 75.5,
    "height": 180,
    "diagnosis": "Knee osteoarthritis",
    "notes": "Referred by Dr. Hassan",
    "otp": "123456",
    "is_verified": true,
    "clinic_group_id": 1,
    "history": [
      {
        "id": 1,
        "date_time": "2026/01/20 & 03:00 PM",
        "therapist_id": 1,
        "therapist_name": "Dr. Ahmed",
        "patient_name": "John Doe",
        "patient_id": 3,
        "price": 150.00,
        "is_completed": true,
        "is_paid": true
      }
    ],
    "treatment_plan": [...]
  }
]
```

---

#### 26. **POST** `/api/protected/CreatePatient`
Create a new patient.

**Request:**
```json
{
  "name": "Ahmed Hassan",
  "phone": "1234567890",
  "gender": "Male",
  "age": 45,
  "weight": 85.0,
  "height": 175,
  "diagnosis": "Lower back pain",
  "notes": "Chronic pain management"
}
```

**Response (200 OK):**
```json
{
  "message": "Patient Created Successfully",
  "id": 10
}
```

---

#### 27. **POST** `/api/protected/UpdatePatient`
Update patient information.

**Request:**
```json
{
  "id": 3,
  "name": "John Doe",
  "gender": "Male",
  "age": 36,
  "weight": 76.0,
  "height": 180,
  "diagnosis": "Knee pain - improved",
  "notes": "Progress: 80% mobility restored"
}
```

**Response (200 OK):**
```json
{
  "message": "Patient Updated Successfully"
}
```

---

#### 28. **POST** `/api/protected/DeletePatient`
Delete a patient.

**Request:**
```json
{
  "patient_id": 3
}
```

**Response (200 OK):**
```json
{
  "message": "Patient Deleted Successfully"
}
```

---

#### 29. **POST** `/api/protected/FetchPatientFilesURLs`
Get list of patient records (files).

**Request:**
```json
{
  "id": 3
}
```

**Response (200 OK):**
```json
[
  {
    "name": "xray_report.pdf",
    "size": 245632
  },
  {
    "name": "medical_history.docx",
    "size": 15360
  }
]
```

---

#### 30. **POST** `/api/protected/UploadPatientRecord`
Upload patient medical records.

**Request:** (Form Data)
```
id: 3
files: [file1.pdf, file2.docx]
```

**Response (200 OK):**
```json
{
  "message": "Files uploaded successfully"
}
```

---

#### 31. **POST** `/api/protected/DeletePatientRecord`
Delete a patient record file.

**Request:**
```json
{
  "id": 3,
  "file_name": "xray_report.pdf"
}
```

**Response (200 OK):**
```json
{
  "message": "File deleted successfully"
}
```

---

### 📦 TREATMENT PACKAGES

#### 32. **GET** `/api/protected/FetchSuperTreatments`
Get all treatment plan templates.

**Response (200 OK):**
```json
[
  {
    "id": 1,
    "description": "Basic Knee Rehabilitation",
    "sessions_count": 10,
    "price": 1500.00,
    "clinic_group_id": 1
  },
  {
    "id": 2,
    "description": "Advanced Shoulder Therapy",
    "sessions_count": 15,
    "price": 2250.00,
    "clinic_group_id": 1
  }
]
```

---

#### 33. **POST** `/api/protected/AddSuperTreatment`
Create a new treatment template.

**Request:**
```json
{
  "description": "Back Pain Treatment",
  "sessions_count": 12,
  "price": 1800.00
}
```

**Response (200 OK):**
```json
{
  "message": "Package Created Successfully",
  "id": 3
}
```

---

#### 34. **POST** `/api/protected/EditSuperTreatment`
Update treatment template.

**Request:**
```json
{
  "id": 1,
  "description": "Basic Knee Rehabilitation - Updated",
  "sessions_count": 12,
  "price": 1800.00
}
```

**Response (200 OK):**
```json
{
  "message": "Package Edited Successfully"
}
```

---

#### 35. **POST** `/api/protected/DeleteSuperTreatment`
Delete treatment template.

**Request:**
```json
{
  "package_id": 3
}
```

**Response (200 OK):**
```json
{
  "message": "Package Deleted Successfully"
}
```

---

#### 36. **POST** `/api/protected/FetchPatientCurrentPackage`
Get active treatment package for patient.

**Request:**
```json
{
  "patient_id": 3
}
```

**Response (200 OK):**
```json
{
  "id": 1,
  "date": "2026/01/01",
  "super_treatment_plan_id": 1,
  "super_treatment_plan": {
    "id": 1,
    "description": "Basic Knee Rehabilitation",
    "sessions_count": 10,
    "price": 1500.00
  },
  "remaining": 7,
  "discount": 10.0,
  "referral_id": 1,
  "total_price": 1350.00,
  "patient_id": 3,
  "payment_method": "card",
  "is_paid": true,
  "appointments": [...]
}
```

---

#### 37. **POST** `/api/protected/FetchPatientPackages`
Get all treatment packages for patient.

**Request:**
```json
{
  "patient_id": 3
}
```

**Response:** Array of treatment plan objects (same structure as above)

---

#### 38. **POST** `/api/protected/FetchPackageAppointments`
Get appointments in a treatment package.

**Request:**
```json
{
  "package_id": 1
}
```

**Response (200 OK):**
```json
[
  {
    "id": 1,
    "date_time": "2026/01/20 & 03:00 PM",
    "therapist_id": 1,
    "therapist_name": "Dr. Ahmed",
    "patient_name": "John Doe",
    "patient_id": 3,
    "price": 150.00,
    "is_completed": true,
    "is_paid": true,
    "treatment_plan_id": 1
  }
]
```

---

#### 39. **POST** `/api/protected/MarkPackageAsPaid`
Mark treatment package as paid.

**Request:**
```json
{
  "package_id": 1,
  "payment_method": "cash"
}
```

**Response (200 OK):**
```json
{
  "message": "Package marked as paid"
}
```

---

#### 40. **POST** `/api/protected/UnMarkPackageAsPaid`
Mark treatment package as unpaid.

**Request:**
```json
{
  "package_id": 1
}
```

**Response (200 OK):**
```json
{
  "message": "Package marked as unpaid"
}
```

---

#### 41. **POST** `/api/protected/RemovePackage`
Delete a treatment package.

**Request:**
```json
{
  "package_id": 1
}
```

**Response (200 OK):**
```json
{
  "message": "Package Removed Successfully"
}
```

---

### 🏥 REFERRAL MANAGEMENT

#### 42. **GET** `/api/protected/FetchReferrals`
Get all referral partners.

**Response (200 OK):**
```json
[
  {
    "id": 1,
    "name": "Dr. Hassan Clinic",
    "cashback_percentage": 15.0,
    "clinic_group_id": 1
  },
  {
    "id": 2,
    "name": "Medical Center Plus",
    "cashback_percentage": 10.0,
    "clinic_group_id": 1
  }
]
```

---

#### 43. **POST** `/api/protected/AddReferral`
Add a new referral partner.

**Request:**
```json
{
  "name": "New Medical Partner",
  "cashback_percentage": 12.5
}
```

**Response (200 OK):**
```json
{
  "message": "Referral Created Successfully"
}
```

---

#### 44. **POST** `/api/protected/EditReferral`
Update referral partner.

**Request:**
```json
{
  "id": 1,
  "name": "Dr. Hassan Clinic - Updated",
  "cashback_percentage": 18.0
}
```

**Response (200 OK):**
```json
{
  "message": "Referral Edited Successfully"
}
```

---

#### 45. **POST** `/api/protected/DeleteReferral`
Delete referral partner.

**Request:**
```json
{
  "referral_id": 1
}
```

**Response (200 OK):**
```json
{
  "message": "Referral Deleted Successfully"
}
```

---

#### 46. **POST** `/api/protected/FetchReferralPackages`
Get treatment packages from a referral.

**Request:**
```json
{
  "referral_id": 1
}
```

**Response:** Array of treatment plans with referral discount applied

---

#### 47. **POST** `/api/protected/SetPackageReferral`
Apply referral discount to treatment package.

**Request:**
```json
{
  "referral_id": 1,
  "package_id": 5,
  "discount": 15.0
}
```

**Response (200 OK):**
```json
{
  "message": "Package Referral Set"
}
```

---

#### 48. **POST** `/api/protected/ExportReferredPackagesExcel`
Export referral packages to Excel.

**Request:**
```json
{
  "referral_id": 1
}
```

**Response:** Excel file download

---

### 📊 DATA EXPORT

#### 49. **POST** `/api/protected/ExportSalesTable`
Export sales/appointments data to Excel.

**Request:**
```json
{
  "start_date": "2026/01/01",
  "end_date": "2026/01/31"
}
```

**Response:** Excel file download

---

### 💬 MESSAGING

#### 50. **GET** `/api/protected/CheckWhatsAppLogin`
Check WhatsApp login status.

**Response (200 OK):**
```json
{
  "is_logged_in": true,
  "phone_number": "+201234567890"
}
```

---

#### 51. **GET** `/api/protected/GetWhatsAppQRCode`
Get WhatsApp QR code for login.

**Response (200 OK):**
```json
{
  "qr_code": "data:image/png;base64,iVBORw0KGgo..."
}
```

---

#### 52. **GET** `/api/protected/RequestSSE`
Server-Sent Events stream for real-time updates.

**Response:** Stream (text/event-stream)
```
event: refresh
data: null

event: notification
data: {"message": "New appointment", "id": 5}
```

---

## Permission Matrix

| Endpoint | Public | Therapist | Admin |
|----------|--------|-----------|-------|
| Login | ✅ | ✅ | ✅ |
| Register | ✅ | ❌ | ✅ |
| Request Appointment | ✅ | ✅ | ✅ |
| View Therapists | ✅ | ✅ | ✅ |
| Manage Therapists | ❌ | ❌ | ✅ |
| Manage Patients | ❌ | ✅ | ✅ |
| Manage Appointments | ❌ | ✅ | ✅ |
| Manage Packages | ❌ | ❌ | ✅ |
| Manage Referrals | ❌ | ❌ | ✅ |
| Export Data | ❌ | ❌ | ✅ |

---

## Data Models

### User
```go
type User struct {
  ID            uint
  Username      string
  Password      string
  Permission    int       // 0=Patient, 1=Therapist, >=2=Admin
  IsFrozen      bool
  ClinicGroupID uint
}
```

### Patient
```go
type Patient struct {
  ID            uint
  Name          string
  Phone         string
  Gender        string
  Age           int
  Weight        float64
  Height        float64
  Diagnosis     string
  Notes         string
  OTP           string
  IsVerified    bool
  ClinicGroupID uint
}
```

### Appointment
```go
type Appointment struct {
  ID              uint
  DateTime        string      // Format: "YYYY/MM/DD & HH:MM AM/PM"
  TherapistID     uint
  TherapistName   string
  PatientID       uint
  PatientName     string
  Price           float64
  IsCompleted     bool
  IsPaid          bool
  PaymentMethod   string      // cash, card, bank transfer
  Notes           string
  TreatmentPlanID *uint
  ReminderSent    bool
  ClinicGroupID   uint
}
```

### Therapist
```go
type Therapist struct {
  ID      uint
  Name    string
  UserID  uint
  Phone   string
  Schedule Schedule
  PhotoUrl string
  IsDemo  bool
}
```

### SuperTreatmentPlan
```go
type SuperTreatmentPlan struct {
  ID            uint
  Description   string      // e.g., "Knee Rehabilitation"
  SessionsCount uint        // Number of sessions
  Price         float64     // Total price
  ClinicGroupID uint
}
```

### TreatmentPlan (Instance)
```go
type TreatmentPlan struct {
  ID                   uint
  SuperTreatmentPlanID uint
  Remaining            uint        // Sessions left
  Discount             float64     // Discount percentage
  ReferralID           *uint
  TotalPrice           float64
  PatientID            uint
  PaymentMethod        string
  IsPaid               bool
  ClinicGroupID        uint
}
```

### Referral
```go
type Referral struct {
  ID                  uint
  Name                string      // Referral partner name
  CashbackPercentage  float64     // Discount percentage
  ClinicGroupID       uint
}
```

---

## Error Handling

Common HTTP Status Codes:

- **200 OK** - Success
- **400 Bad Request** - Invalid input or business rule violation
- **401 Unauthorized** - Invalid/missing JWT token
- **403 Forbidden** - Insufficient permissions
- **404 Not Found** - Resource not found
- **500 Internal Server Error** - Server error

Error Response Format:
```json
{
  "error": "Description of error"
}
```

---

## Key Business Rules

1. **Appointment Booking**
   - Non-admin users cannot book > 14 days in advance
   - Each patient can only have one appointment per day
   - Time blocks must be available in therapist's schedule

2. **Treatment Packages**
   - Can apply discount for referral
   - Total price = SuperTreatmentPlan.Price × ((100 - Discount) / 100)
   - Remaining sessions tracked per patient

3. **Data Isolation**
   - All data queries automatically scoped to user's clinic_group_id
   - Users can only see data from their clinic group

4. **Patient Verification**
   - Phone numbers must be unique or marked as existing
   - OTP generated for new patients
   - Patient can be verified before appointment

5. **Notifications**
   - Firebase Cloud Messaging for push notifications
   - WhatsApp reminders for upcoming appointments
   - SSE stream for real-time UI updates

---

## Authentication Token Format

JWT tokens contain:
```
Header:  {
  "alg": "HS256",
  "typ": "JWT"
}

Payload: {
  "user_id": 5,
  "username": "therapist@clinic.com",
  "exp": 1642204800
}
```

Token is validated on every protected route and automatically decoded to extract `user_id`.
