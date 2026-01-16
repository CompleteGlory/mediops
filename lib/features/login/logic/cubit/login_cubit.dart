import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediops/core/networks/api_result.dart';
import 'package:mediops/features/login/data/models/login_reponse.dart';
import '../../data/models/login_request_body.dart';
import '../../data/repos/login_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState<LoginResponse>> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool obscurePassword = true;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    emit(const LoginState.initial());
  }

  Future<void> login() async {
  if (!formKey.currentState!.validate()) return;

  emit(const LoginState.loading());

  final body = LoginRequestBody(
    username: userNameController.text.trim(),
    password: passwordController.text,
  );

  final result = await _loginRepo.login(body);

  result.when(
    success: (data) {
      emit(LoginState.success(data));
    },
    failure: (error) {
      emit(LoginState.failure(error.message.toString())); // ✅ STRING ONLY
    },
  );
}


}
