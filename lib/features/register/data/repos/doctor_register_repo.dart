import 'package:mediops/core/networks/api_result.dart';
import 'package:mediops/core/networks/api_services.dart';
import 'package:mediops/features/register/data/models/doctor_register_response.dart';
import '../models/doctor_register_request_body.dart';

class DoctorRegisterRepo {
  final ApiService _apiService;

  DoctorRegisterRepo(this._apiService);

  Future<ApiResult<DoctorRegisterResponse>> registerDoctor(
      DoctorRegisterRequestBody body) async {
   // try {
      final response = await _apiService.registerDoctor(body);
      // If response is successful, return empty response with success
      final doctorResponse = response.data;
      return ApiResult.success(doctorResponse);
    // } catch (e) {
    //   return ApiResult.failure(ApiErrorHandler.handle(e));
    // }
  }
}
