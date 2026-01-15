import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediops/core/networks/api_result.dart';
import 'package:mediops/features/register/data/models/register_response.dart';
import '../../data/models/register_request_body.dart';
import '../../data/repos/register_repo.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState<RegisterResponse>> {
  final RegisterRepo _registerRepo;
  RegisterCubit(this._registerRepo) : super(const RegisterState.initial());

  TextEditingController clinicNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool obscurePassword = true;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    emit(const RegisterState.initial());
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    emit(const RegisterState.loading());

    final body = RegisterRequestBody(
      name: clinicNameController.text.trim(),
      password: passwordController.text,
    );

    final result = await _registerRepo.register(body);

    result.when(
      success: (data) {
        emit(RegisterState.success(data));
      },
      failure: (error) {
        emit(RegisterState.failure(error.message.toString()));
      },
    );
  }
}
