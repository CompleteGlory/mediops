import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediops/core/networks/api_result.dart';
import 'package:mediops/features/register/data/models/doctor_register_response.dart';
import '../../data/models/doctor_register_request_body.dart';
import '../../data/repos/doctor_register_repo.dart';
import 'doctor_register_state.dart';

class DoctorRegisterCubit extends Cubit<DoctorRegisterState<DoctorRegisterResponse>> {
  final DoctorRegisterRepo _doctorRegisterRepo;
  DoctorRegisterCubit(this._doctorRegisterRepo) : super(const DoctorRegisterState.initial());

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  int? registrationPermission; // Store permission for navigation

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    emit(const DoctorRegisterState.initial());
  }

  Future<void> registerDoctor({required int permission}) async {
    if (!formKey.currentState!.validate()) return;

    emit(const DoctorRegisterState.loading());
    registrationPermission = permission; // Store for later navigation

    final body = DoctorRegisterRequestBody(
      username: usernameController.text.trim(),
      password: passwordController.text,
      permission: permission,
    );

    final result = await _doctorRegisterRepo.registerDoctor(body);

    result.when(
      success: (data) {
        emit(DoctorRegisterState.success(data));
      },
      failure: (error) {
        emit(DoctorRegisterState.failure(error.message.toString()));
      },
    );
  }
}
