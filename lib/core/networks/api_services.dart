import 'package:dio/dio.dart';
import 'package:mediops/core/networks/api_constatns.dart';
import 'package:mediops/features/login/data/models/login_reponse.dart';
import 'package:mediops/features/login/data/models/login_request_body.dart';
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

  @POST(ApiConstants.register)
  Future<HttpResponse<RegisterResponse>> register(
    @Body() RegisterRequestBody registerRequestBody,
  );
}
