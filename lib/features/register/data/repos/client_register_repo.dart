import 'package:mediops/core/networks/api_error_handler.dart';
import 'package:mediops/core/networks/api_result.dart';
import 'package:mediops/core/networks/api_services.dart';
import 'package:mediops/features/register/data/models/client_register_request_body.dart';
import 'package:mediops/features/register/data/models/client_register_response.dart';

class ClientRegisterRepo {
  final ApiService _apiService;

  ClientRegisterRepo(this._apiService);

  Future<ApiResult<ClientRegisterResponse>> registerClient(
    ClientRegisterRequestBody body,
  ) async {
    try {
      final response = await _apiService.registerClient(body);
      // If response is successful, return empty response with success
      final clientResponse = response.data;
      return ApiResult.success(clientResponse);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
