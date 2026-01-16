import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediops/core/networks/api_result.dart';
import 'package:mediops/features/register/data/models/client_register_response.dart';
import '../../data/models/client_register_request_body.dart';
import '../../data/repos/client_register_repo.dart';
import 'client_register_state.dart';

class ClientRegisterCubit extends Cubit<ClientRegisterState<ClientRegisterResponse>> {
  final ClientRegisterRepo _clientRegisterRepo;
  ClientRegisterCubit(this._clientRegisterRepo) : super(const ClientRegisterState.initial());

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool obscurePassword = true;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    emit(const ClientRegisterState.initial());
  }

  Future<void> registerClient() async {
    if (!formKey.currentState!.validate()) return;

    emit(const ClientRegisterState.loading());

    final body = ClientRegisterRequestBody(
      username: usernameController.text.trim(),
      password: passwordController.text,
    );

    final result = await _clientRegisterRepo.registerClient(body);

    result.when(
      success: (data) {
        emit(ClientRegisterState.success(data));
      },
      failure: (error) {
        emit(ClientRegisterState.failure(error.message.toString()));
      },
    );
  }
}
