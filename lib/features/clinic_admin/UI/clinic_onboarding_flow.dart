// clinic_onboarding_flow.dart
// Main onboarding flow with edit functionality
// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediops/core/themes/app_colors.dart';
import 'package:mediops/core/widgets/spacing.dart';

// Import step widgets
import 'widgets/doctors_form_step.dart';
import 'widgets/patients_form_step.dart';
import 'widgets/packages_form_step.dart';
import 'widgets/discounts_form_step.dart';
import 'widgets/modern_progress_indicator.dart';
import 'widgets/modern_bottom_nav.dart';

class ClinicOnboardingFlow extends StatefulWidget {
  const ClinicOnboardingFlow({super.key});

  @override
  State<ClinicOnboardingFlow> createState() => _ClinicOnboardingFlowState();
}

class _ClinicOnboardingFlowState extends State<ClinicOnboardingFlow> with TickerProviderStateMixin {
  int currentStep = 0;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  // Data lists
  final List<Map<String, String>> doctors = [];
  final List<Map<String, String>> patients = [];
  final List<Map<String, String>> packages = [];
  final List<Map<String, String>> discounts = [];

  // Controllers for doctors
  final TextEditingController doctorNameCtrl = TextEditingController();
  final TextEditingController doctorSpecialtyCtrl = TextEditingController();
  
  // Controllers for patients
  final TextEditingController patientNameCtrl = TextEditingController();
  final TextEditingController patientPhoneCtrl = TextEditingController();
  
  // Controllers for packages
  final TextEditingController packageNameCtrl = TextEditingController();
  final TextEditingController packagePriceCtrl = TextEditingController();
  
  // Controllers for discounts
  final TextEditingController discountNameCtrl = TextEditingController();
  final TextEditingController discountPercentCtrl = TextEditingController();

  // Edit mode tracking
  int? editingDoctorIndex;
  int? editingPatientIndex;
  int? editingPackageIndex;
  int? editingDiscountIndex;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    doctorNameCtrl.dispose();
    doctorSpecialtyCtrl.dispose();
    patientNameCtrl.dispose();
    patientPhoneCtrl.dispose();
    packageNameCtrl.dispose();
    packagePriceCtrl.dispose();
    discountNameCtrl.dispose();
    discountPercentCtrl.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (currentStep < 3) {
      _slideController.reset();
      setState(() => currentStep++);
      _slideController.forward();
    } else {
      _finishOnboarding();
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      _slideController.reset();
      setState(() => currentStep--);
      _slideController.forward();
    }
  }

  void _finishOnboarding() {
    // Call backend or navigate
    debugPrint('Doctors: $doctors');
    debugPrint('Patients: $patients');
    debugPrint('Packages: $packages');
    debugPrint('Discounts: $discounts');
  }

  bool _canProceedToNext() {
    switch (currentStep) {
      case 0:
        return doctors.isNotEmpty;
      case 1:
        return patients.isNotEmpty;
      case 2:
        return packages.isNotEmpty;
      case 3:
        return discounts.isNotEmpty;
      default:
        return false;
    }
  }

  // Doctor operations
  void _saveDoctor() {
    if (doctorNameCtrl.text.trim().isEmpty) return;
    
    setState(() {
      if (editingDoctorIndex != null) {
        // Update existing
        doctors[editingDoctorIndex!] = {
          'name': doctorNameCtrl.text.trim(),
          'specialty': doctorSpecialtyCtrl.text.trim(),
        };
        editingDoctorIndex = null;
      } else {
        // Add new
        doctors.add({
          'name': doctorNameCtrl.text.trim(),
          'specialty': doctorSpecialtyCtrl.text.trim(),
        });
      }
      doctorNameCtrl.clear();
      doctorSpecialtyCtrl.clear();
    });
  }

  void _editDoctor(int index) {
    setState(() {
      editingDoctorIndex = index;
      doctorNameCtrl.text = doctors[index]['name'] ?? '';
      doctorSpecialtyCtrl.text = doctors[index]['specialty'] ?? '';
    });
  }

  void _deleteDoctor(int index) {
    setState(() {
      doctors.removeAt(index);
      if (editingDoctorIndex == index) {
        editingDoctorIndex = null;
        doctorNameCtrl.clear();
        doctorSpecialtyCtrl.clear();
      }
    });
  }

  void _cancelEditDoctor() {
    setState(() {
      editingDoctorIndex = null;
      doctorNameCtrl.clear();
      doctorSpecialtyCtrl.clear();
    });
  }

  // Patient operations
  void _savePatient() {
    if (patientNameCtrl.text.trim().isEmpty) return;
    
    setState(() {
      if (editingPatientIndex != null) {
        patients[editingPatientIndex!] = {
          'name': patientNameCtrl.text.trim(),
          'phone': patientPhoneCtrl.text.trim(),
        };
        editingPatientIndex = null;
      } else {
        patients.add({
          'name': patientNameCtrl.text.trim(),
          'phone': patientPhoneCtrl.text.trim(),
        });
      }
      patientNameCtrl.clear();
      patientPhoneCtrl.clear();
    });
  }

  void _editPatient(int index) {
    setState(() {
      editingPatientIndex = index;
      patientNameCtrl.text = patients[index]['name'] ?? '';
      patientPhoneCtrl.text = patients[index]['phone'] ?? '';
    });
  }

  void _deletePatient(int index) {
    setState(() {
      patients.removeAt(index);
      if (editingPatientIndex == index) {
        editingPatientIndex = null;
        patientNameCtrl.clear();
        patientPhoneCtrl.clear();
      }
    });
  }

  void _cancelEditPatient() {
    setState(() {
      editingPatientIndex = null;
      patientNameCtrl.clear();
      patientPhoneCtrl.clear();
    });
  }

  // Package operations
  void _savePackage() {
    if (packageNameCtrl.text.trim().isEmpty) return;
    
    setState(() {
      if (editingPackageIndex != null) {
        packages[editingPackageIndex!] = {
          'name': packageNameCtrl.text.trim(),
          'price': packagePriceCtrl.text.trim(),
        };
        editingPackageIndex = null;
      } else {
        packages.add({
          'name': packageNameCtrl.text.trim(),
          'price': packagePriceCtrl.text.trim(),
        });
      }
      packageNameCtrl.clear();
      packagePriceCtrl.clear();
    });
  }

  void _editPackage(int index) {
    setState(() {
      editingPackageIndex = index;
      packageNameCtrl.text = packages[index]['name'] ?? '';
      packagePriceCtrl.text = packages[index]['price'] ?? '';
    });
  }

  void _deletePackage(int index) {
    setState(() {
      packages.removeAt(index);
      if (editingPackageIndex == index) {
        editingPackageIndex = null;
        packageNameCtrl.clear();
        packagePriceCtrl.clear();
      }
    });
  }

  void _cancelEditPackage() {
    setState(() {
      editingPackageIndex = null;
      packageNameCtrl.clear();
      packagePriceCtrl.clear();
    });
  }

  // Discount operations
  void _saveDiscount() {
    if (discountNameCtrl.text.trim().isEmpty) return;
    
    setState(() {
      if (editingDiscountIndex != null) {
        discounts[editingDiscountIndex!] = {
          'name': discountNameCtrl.text.trim(),
          'percent': discountPercentCtrl.text.trim(),
        };
        editingDiscountIndex = null;
      } else {
        discounts.add({
          'name': discountNameCtrl.text.trim(),
          'percent': discountPercentCtrl.text.trim(),
        });
      }
      discountNameCtrl.clear();
      discountPercentCtrl.clear();
    });
  }

  void _editDiscount(int index) {
    setState(() {
      editingDiscountIndex = index;
      discountNameCtrl.text = discounts[index]['name'] ?? '';
      discountPercentCtrl.text = discounts[index]['percent'] ?? '';
    });
  }

  void _deleteDiscount(int index) {
    setState(() {
      discounts.removeAt(index);
      if (editingDiscountIndex == index) {
        editingDiscountIndex = null;
        discountNameCtrl.clear();
        discountPercentCtrl.clear();
      }
    });
  }

  void _cancelEditDiscount() {
    setState(() {
      editingDiscountIndex = null;
      discountNameCtrl.clear();
      discountPercentCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: currentStep > 0
            ? IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: AppColors.secondary, size: 20.sp),
                onPressed: _previousStep,
              )
            : null,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Center(
              child: Text(
                'Step ${currentStep + 1}/4',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondary.withOpacity(0.6),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            ModernProgressIndicator(
              currentStep: currentStep,
              completed: [
                doctors.isNotEmpty,
                patients.isNotEmpty,
                packages.isNotEmpty,
                discounts.isNotEmpty,
              ],
            ),
            verticalSpace(24),
            Expanded(
              child: SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: _buildStep(),
                ),
              ),
            ),
            ModernBottomNav(
              currentStep: currentStep,
              onNext: _nextStep,
              canProceed: _canProceedToNext(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep() {
    switch (currentStep) {
      case 0:
        return DoctorsFormStep(
          doctors: doctors,
          nameCtrl: doctorNameCtrl,
          specialtyCtrl: doctorSpecialtyCtrl,
          onSave: _saveDoctor,
          onEdit: _editDoctor,
          onDelete: _deleteDoctor,
          onCancelEdit: _cancelEditDoctor,
          editingIndex: editingDoctorIndex,
        );
      case 1:
        return PatientsFormStep(
          patients: patients,
          nameCtrl: patientNameCtrl,
          phoneCtrl: patientPhoneCtrl,
          onSave: _savePatient,
          onEdit: _editPatient,
          onDelete: _deletePatient,
          onCancelEdit: _cancelEditPatient,
          editingIndex: editingPatientIndex,
        );
      case 2:
        return PackagesFormStep(
          packages: packages,
          nameCtrl: packageNameCtrl,
          priceCtrl: packagePriceCtrl,
          onSave: _savePackage,
          onEdit: _editPackage,
          onDelete: _deletePackage,
          onCancelEdit: _cancelEditPackage,
          editingIndex: editingPackageIndex,
        );
      case 3:
        return DiscountsFormStep(
          discounts: discounts,
          nameCtrl: discountNameCtrl,
          percentCtrl: discountPercentCtrl,
          onSave: _saveDiscount,
          onEdit: _editDiscount,
          onDelete: _deleteDiscount,
          onCancelEdit: _cancelEditDiscount,
          editingIndex: editingDiscountIndex,
        );
      default:
        return const SizedBox();
    }
  }
}