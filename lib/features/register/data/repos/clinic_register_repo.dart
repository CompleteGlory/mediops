import 'package:mediops/core/networks/api_error_handler.dart';
import 'package:mediops/core/networks/api_result.dart';
import 'package:mediops/core/networks/api_services.dart';
import 'package:mediops/features/register/data/models/register_response.dart';
import '../models/register_request_body.dart';


class ClinicRegisterRepo {
  final ApiService _apiService;

  ClinicRegisterRepo(this._apiService);

  Future<ApiResult<RegisterResponse>> register(RegisterRequestBody body) async {
    try {
      final response = await _apiService.register(body);
      // If response is successful, return with data or default response
      final registerResponse = response.data;
      return ApiResult.success(registerResponse);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
