import 'package:dio/dio.dart';
import 'package:mediops/core/networks/api_error_handler.dart';
import 'package:mediops/core/networks/api_result.dart';
import 'package:mediops/core/networks/api_services.dart';
import 'package:mediops/features/login/data/models/login_reponse.dart';
import '../models/login_request_body.dart';


class LoginRepo {
  final ApiService _apiService;

  LoginRepo(this._apiService);

  Future<ApiResult<LoginResponse>> login(LoginRequestBody body) async {
    try {
      final response = await _apiService.login(body);
      return ApiResult.success(response.data);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
