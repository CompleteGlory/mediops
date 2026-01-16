import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediops/core/networks/api_result.dart';
import 'package:mediops/features/register/data/models/register_response.dart';
import '../../data/models/register_request_body.dart';
import '../../data/repos/clinic_register_repo.dart';
import 'clinic_register_state.dart';

class ClinicRegisterCubit extends Cubit<ClinicRegisterState<RegisterResponse>> {
  final ClinicRegisterRepo _registerRepo;
  ClinicRegisterCubit(this._registerRepo) : super(const ClinicRegisterState.initial());

  TextEditingController clinicNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool obscurePassword = true;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    emit(const ClinicRegisterState.initial());
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    emit(const ClinicRegisterState.loading());

    final body = RegisterRequestBody(
      name: clinicNameController.text.trim(),
      password: passwordController.text,
    );

    final result = await _registerRepo.register(body);

    result.when(
      success: (data) {
        emit(ClinicRegisterState.success(data));
      },
      failure: (error) {
        emit(ClinicRegisterState.failure(error.message.toString()));
      },
    );
  }
}
