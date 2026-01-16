import 'package:dio/dio.dart';
import 'package:mediops/core/networks/api_constatns.dart';
import 'package:mediops/features/login/data/models/login_reponse.dart';
import 'package:mediops/features/login/data/models/login_request_body.dart';
import 'package:mediops/features/register/data/models/client_register_request_body.dart';
import 'package:mediops/features/register/data/models/client_register_response.dart';
import 'package:mediops/features/register/data/models/doctor_register_request_body.dart';
import 'package:mediops/features/register/data/models/doctor_register_response.dart';
import 'package:mediops/features/register/data/models/register_request_body.dart';
import 'package:mediops/features/register/data/models/register_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<HttpResponse<LoginResponse>> login(
    @Body() LoginRequestBody loginRequestBody,
  );

  @POST(ApiConstants.registerClinic)
  Future<HttpResponse<RegisterResponse>> register(
    @Body() RegisterRequestBody registerRequestBody,
  );

  @POST(ApiConstants.registerDoctor)
  Future<HttpResponse<DoctorRegisterResponse>> registerDoctor(
    @Body() DoctorRegisterRequestBody doctorRegisterRequestBody,
  );

  @POST(ApiConstants.registerClient)
  Future<HttpResponse<ClientRegisterResponse>> registerClient(
    @Body() ClientRegisterRequestBody clientRegisterRequestBody,
  );
}
