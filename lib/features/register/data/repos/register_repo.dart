import 'package:mediops/core/networks/api_error_handler.dart';
import 'package:mediops/core/networks/api_result.dart';
import 'package:mediops/core/networks/api_services.dart';
import 'package:mediops/features/register/data/models/register_response.dart';
import '../models/register_request_body.dart';


class RegisterRepo {
  final ApiService _apiService;

  RegisterRepo(this._apiService);

  Future<ApiResult<RegisterResponse>> register(RegisterRequestBody body) async {
    try {
      final response = await _apiService.register(body);
      return ApiResult.success(response.data);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
