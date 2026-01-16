// widgets/packages_form_step.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediops/core/widgets/app_primary_button.dart';
import 'package:mediops/core/widgets/app_text_field.dart';
import 'package:mediops/core/widgets/spacing.dart';
import 'package:mediops/core/themes/app_colors.dart';
import 'modern_step_header.dart';
import 'modern_data_card.dart';

class PackagesFormStep extends StatelessWidget {
  final List<Map<String, String>> packages;
  final TextEditingController nameCtrl;
  final TextEditingController priceCtrl;
  final VoidCallback onSave;
  final Function(int) onEdit;
  final Function(int) onDelete;
  final VoidCallback onCancelEdit;
  final int? editingIndex;

  const PackagesFormStep({
    required this.packages,
    required this.nameCtrl,
    required this.priceCtrl,
    required this.onSave,
    required this.onEdit,
    required this.onDelete,
    required this.onCancelEdit,
    this.editingIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isEditing = editingIndex != null;
    
    return SingleChildScrollView(
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ModernStepHeader(
            icon: Icons.inventory_2_rounded,
            iconColor: Color(0xFFFF9800),
            title: 'Add Packages',
            subtitle: 'Define treatment packages',
          ),
          verticalSpace(32),
          
          Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 600.w),
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
                if (isEditing)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.edit, size: 18.sp, color: AppColors.primary),
                        horizontalSpace(8),
                        Expanded(
                          child: Text(
                            'Editing package',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: onCancelEdit,
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                AppTextField(label: 'Package Name', controller: nameCtrl),
                verticalSpace(16),
                AppTextField(label: 'Price (EGP)', controller: priceCtrl),
                verticalSpace(20),
                AppPrimaryButton(
                  text: isEditing ? 'Update Package' : '+ Add Package',
                  onPressed: onSave,
                ),
              ],
            ),
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
            ...packages.asMap().entries.map((entry) => ModernDataCard(
                  icon: Icons.card_giftcard_rounded,
                  iconBg: const Color(0xFFFF9800).withOpacity(0.1),
                  iconColor: const Color(0xFFFF9800),
                  title: entry.value['name'] ?? '',
                  subtitle: '${entry.value['price']} EGP',
                  onEdit: () => onEdit(entry.key),
                  onDelete: () => onDelete(entry.key),
                  isEditing: editingIndex == entry.key,
                )),
          ],
        ],
      ),
    );
  }
}