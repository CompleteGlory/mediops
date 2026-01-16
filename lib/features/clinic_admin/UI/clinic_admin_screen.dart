// Modern Clinic Admin Onboarding Flow - Fixed Type Issues + Better UX
// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediops/core/themes/app_colors.dart';
import 'package:mediops/core/widgets/app_primary_button.dart';
import 'package:mediops/core/widgets/app_text_field.dart';
import 'package:mediops/core/widgets/spacing.dart';

class ClinicOnboardingFlow extends StatefulWidget {
  const ClinicOnboardingFlow({super.key});

  @override
  State<ClinicOnboardingFlow> createState() => _ClinicOnboardingFlowState();
}

class _ClinicOnboardingFlowState extends State<ClinicOnboardingFlow> with TickerProviderStateMixin {
  int currentStep = 0;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  // Fixed: Changed to Map<String, String> to match the error
  final List<Map<String, String>> doctors = [];
  final List<Map<String, String>> patients = [];
  final List<Map<String, String>> packages = [];
  final List<Map<String, String>> discounts = [];

  // Controllers
  final TextEditingController doctorNameCtrl = TextEditingController();
  final TextEditingController doctorSpecialtyCtrl = TextEditingController();
  final TextEditingController patientNameCtrl = TextEditingController();
  final TextEditingController patientPhoneCtrl = TextEditingController();
  final TextEditingController packageNameCtrl = TextEditingController();
  final TextEditingController packagePriceCtrl = TextEditingController();
  final TextEditingController discountNameCtrl = TextEditingController();
  final TextEditingController discountPercentCtrl = TextEditingController();

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
            _ModernProgressIndicator(
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
            _ModernBottomNav(
              currentStep: currentStep,
              onNext: _nextStep,
              canProceed: _canProceedToNext(),
            ),
          ],
        ),
      ),
    );
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

  Widget _buildStep() {
    switch (currentStep) {
      case 0:
        return DoctorsFormStep(
          doctors: doctors,
          nameCtrl: doctorNameCtrl,
          specialtyCtrl: doctorSpecialtyCtrl,
          onSave: () {
            if (doctorNameCtrl.text.trim().isEmpty) return;
            setState(() {
              doctors.add({
                'name': doctorNameCtrl.text.trim(),
                'specialty': doctorSpecialtyCtrl.text.trim(),
              });
              doctorNameCtrl.clear();
              doctorSpecialtyCtrl.clear();
            });
          },
          onDelete: (index) => setState(() => doctors.removeAt(index)),
        );
      case 1:
        return PatientsFormStep(
          patients: patients,
          nameCtrl: patientNameCtrl,
          phoneCtrl: patientPhoneCtrl,
          onSave: () {
            if (patientNameCtrl.text.trim().isEmpty) return;
            setState(() {
              patients.add({
                'name': patientNameCtrl.text.trim(),
                'phone': patientPhoneCtrl.text.trim(),
              });
              patientNameCtrl.clear();
              patientPhoneCtrl.clear();
            });
          },
          onDelete: (index) => setState(() => patients.removeAt(index)),
        );
      case 2:
        return PackagesFormStep(
          packages: packages,
          nameCtrl: packageNameCtrl,
          priceCtrl: packagePriceCtrl,
          onSave: () {
            if (packageNameCtrl.text.trim().isEmpty) return;
            setState(() {
              packages.add({
                'name': packageNameCtrl.text.trim(),
                'price': packagePriceCtrl.text.trim(),
              });
              packageNameCtrl.clear();
              packagePriceCtrl.clear();
            });
          },
          onDelete: (index) => setState(() => packages.removeAt(index)),
        );
      case 3:
        return DiscountsFormStep(
          discounts: discounts,
          nameCtrl: discountNameCtrl,
          percentCtrl: discountPercentCtrl,
          onSave: () {
            if (discountNameCtrl.text.trim().isEmpty) return;
            setState(() {
              discounts.add({
                'name': discountNameCtrl.text.trim(),
                'percent': discountPercentCtrl.text.trim(),
              });
              discountNameCtrl.clear();
              discountPercentCtrl.clear();
            });
          },
          onDelete: (index) => setState(() => discounts.removeAt(index)),
        );
      default:
        return const SizedBox();
    }
  }
}

/* ---------------- FORM STEP WIDGETS ---------------- */

class DoctorsFormStep extends StatelessWidget {
  final List<Map<String, String>> doctors;
  final TextEditingController nameCtrl;
  final TextEditingController specialtyCtrl;
  final VoidCallback onSave;
  final Function(int) onDelete;

  const DoctorsFormStep({
    required this.doctors,
    required this.nameCtrl,
    required this.specialtyCtrl,
    required this.onSave,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _ModernStepHeader(
            icon: Icons.medical_services_rounded,
            iconColor: const Color(0xFF4CAF50),
            title: 'Add Doctors',
            subtitle: 'Register healthcare professionals',
          ),
          verticalSpace(32),
          
          // Form Card
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                AppTextField(label: 'Doctor Name', controller: nameCtrl),
                verticalSpace(16),
                AppTextField(label: 'Specialty', controller: specialtyCtrl),
                verticalSpace(20),
                AppPrimaryButton(text: '+ Add Doctor', onPressed: onSave),
              ],
            ),
          ),
          
          if (doctors.isNotEmpty) ...[
            verticalSpace(24),
            Text(
              'Added Doctors (${doctors.length})',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.secondary,
              ),
            ),
            verticalSpace(12),
            ...doctors.asMap().entries.map((entry) => _ModernDataCard(
                  icon: Icons.person_rounded,
                  iconBg: const Color(0xFF4CAF50).withOpacity(0.1),
                  iconColor: const Color(0xFF4CAF50),
                  title: entry.value['name'] ?? '',
                  subtitle: entry.value['specialty'] ?? '',
                  onDelete: () => onDelete(entry.key),
                )),
          ],
        ],
      ),
    );
  }
}

class PatientsFormStep extends StatelessWidget {
  final List<Map<String, String>> patients;
  final TextEditingController nameCtrl;
  final TextEditingController phoneCtrl;
  final VoidCallback onSave;
  final Function(int) onDelete;

  const PatientsFormStep({
    required this.patients,
    required this.nameCtrl,
    required this.phoneCtrl,
    required this.onSave,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _ModernStepHeader(
            icon: Icons.people_rounded,
            iconColor: const Color(0xFF2196F3),
            title: 'Add Patients',
            subtitle: 'Create patient profiles',
          ),
          verticalSpace(32),
          
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                AppTextField(label: 'Patient Name', controller: nameCtrl),
                verticalSpace(16),
                AppTextField(label: 'Phone Number', controller: phoneCtrl),
                verticalSpace(20),
                AppPrimaryButton(text: '+ Add Patient', onPressed: onSave),
              ],
            ),
          ),
          
          if (patients.isNotEmpty) ...[
            verticalSpace(24),
            Text(
              'Added Patients (${patients.length})',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.secondary,
              ),
            ),
            verticalSpace(12),
            ...patients.asMap().entries.map((entry) => _ModernDataCard(
                  icon: Icons.account_circle_rounded,
                  iconBg: const Color(0xFF2196F3).withOpacity(0.1),
                  iconColor: const Color(0xFF2196F3),
                  title: entry.value['name'] ?? '',
                  subtitle: entry.value['phone'] ?? '',
                  onDelete: () => onDelete(entry.key),
                )),
          ],
        ],
      ),
    );
  }
}

class PackagesFormStep extends StatelessWidget {
  final List<Map<String, String>> packages;
  final TextEditingController nameCtrl;
  final TextEditingController priceCtrl;
  final VoidCallback onSave;
  final Function(int) onDelete;

  const PackagesFormStep({
    required this.packages,
    required this.nameCtrl,
    required this.priceCtrl,
    required this.onSave,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _ModernStepHeader(
            icon: Icons.inventory_2_rounded,
            iconColor: const Color(0xFFFF9800),
            title: 'Add Packages',
            subtitle: 'Define treatment packages',
          ),
          verticalSpace(32),
          
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                AppTextField(label: 'Package Name', controller: nameCtrl),
                verticalSpace(16),
                AppTextField(label: 'Price (EGP)', controller: priceCtrl),
                verticalSpace(20),
                AppPrimaryButton(text: '+ Add Package', onPressed: onSave),
              ],
            ),
          ),
          
          if (packages.isNotEmpty) ...[
            verticalSpace(24),
            Text(
              'Added Packages (${packages.length})',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.secondary,
              ),
            ),
            verticalSpace(12),
            ...packages.asMap().entries.map((entry) => _ModernDataCard(
                  icon: Icons.card_giftcard_rounded,
                  iconBg: const Color(0xFFFF9800).withOpacity(0.1),
                  iconColor: const Color(0xFFFF9800),
                  title: entry.value['name'] ?? '',
                  subtitle: '${entry.value['price']} EGP',
                  onDelete: () => onDelete(entry.key),
                )),
          ],
        ],
      ),
    );
  }
}

class DiscountsFormStep extends StatelessWidget {
  final List<Map<String, String>> discounts;
  final TextEditingController nameCtrl;
  final TextEditingController percentCtrl;
  final VoidCallback onSave;
  final Function(int) onDelete;

  const DiscountsFormStep({
    required this.discounts,
    required this.nameCtrl,
    required this.percentCtrl,
    required this.onSave,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _ModernStepHeader(
            icon: Icons.local_offer_rounded,
            iconColor: const Color(0xFFE91E63),
            title: 'Add Discounts',
            subtitle: 'Create discount offers',
          ),
          verticalSpace(32),
          
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                AppTextField(label: 'Discount Name', controller: nameCtrl),
                verticalSpace(16),
                AppTextField(label: 'Percentage (%)', controller: percentCtrl),
                verticalSpace(20),
                AppPrimaryButton(text: '+ Add Discount', onPressed: onSave),
              ],
            ),
          ),
          
          if (discounts.isNotEmpty) ...[
            verticalSpace(24),
            Text(
              'Added Discounts (${discounts.length})',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.secondary,
              ),
            ),
            verticalSpace(12),
            ...discounts.asMap().entries.map((entry) => _ModernDataCard(
                  icon: Icons.discount_rounded,
                  iconBg: const Color(0xFFE91E63).withOpacity(0.1),
                  iconColor: const Color(0xFFE91E63),
                  title: entry.value['name'] ?? '',
                  subtitle: '${entry.value['percent']}% off',
                  onDelete: () => onDelete(entry.key),
                )),
          ],
        ],
      ),
    );
  }
}

/* ------------------ UI COMPONENTS ------------------ */

class _ModernStepHeader extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _ModernStepHeader({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 40.sp, color: iconColor),
        ),
        verticalSpace(16),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.secondary,
          ),
        ),
        verticalSpace(8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.sp,
            color: AppColors.secondary.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}

class _ModernDataCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onDelete;

  const _ModernDataCard({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: iconColor, size: 24.sp),
          ),
          horizontalSpace(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondary,
                  ),
                ),
                verticalSpace(4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.secondary.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, color: Colors.red.withOpacity(0.7)),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

class _ModernProgressIndicator extends StatelessWidget {
  final int currentStep;
  final List<bool> completed;

  const _ModernProgressIndicator({
    required this.currentStep,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: List.generate(4, (index) {
          final isDone = completed[index];
          final isActive = index == currentStep;
          final isPassed = index < currentStep;
          
          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 4.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      gradient: isDone || isPassed
                          ? LinearGradient(
                              colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
                            )
                          : null,
                      color: isDone || isPassed
                          ? null
                          : isActive
                              ? AppColors.primary.withOpacity(0.3)
                              : Colors.grey.withOpacity(0.2),
                    ),
                  ),
                ),
                if (index < 3) horizontalSpace(8),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _ModernBottomNav extends StatelessWidget {
  final int currentStep;
  final VoidCallback onNext;
  final bool canProceed;

  const _ModernBottomNav({
    required this.currentStep,
    required this.onNext,
    required this.canProceed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: AppPrimaryButton(
          text: currentStep == 3 ? 'Finish Setup' : 'Continue',
          onPressed: canProceed ? onNext : (){},
        ),
      ),
    );
  }
}