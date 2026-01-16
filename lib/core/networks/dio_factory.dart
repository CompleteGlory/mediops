import 'package:dio/dio.dart';
import 'package:mediops/core/helpers/constants.dart';
import 'package:mediops/core/helpers/shared_pref_helper.dart';
import 'package:mediops/core/routing/navigation_services.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


class DioFactory {
  DioFactory._();

  static Dio? _dio;

  static Dio getDio() {
    if (_dio != null) return _dio!;

    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    _addHeaders(dio);
    _addInterceptors(dio);

    _dio = dio;
    return dio;
  }

  /// Add Authorization header
  static Future<void> _addHeaders(Dio dio) async {
    final token =
        await SharedPrefHelper.getString(SharedPrefKeys.userToken);

    if (token != null && token.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  /// Update token after login
  static void setTokenIntoHeaderAfterLogin(String token) {
    _dio?.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Interceptors (Logger + Auth handling)
  static void _addInterceptors(Dio dio) {
    /// Logger
    dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
        error: true,
      ),
    );

    /// Handle empty responses - convert to empty object
    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          // If response is successful but has empty body, convert to empty JSON object
          if (response.statusCode == 200 && (response.data == null || response.data == '')) {
            response.data = <String, dynamic>{};
          }
          // Ensure data is always a proper Map<String, dynamic>
          else if (response.statusCode == 200 && response.data is Map) {
            response.data = Map<String, dynamic>.from(response.data as Map);
          }
          return handler.next(response);
        },
      ),
    );

    /// Handle Unauthorized
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException err, handler) {
          final statusCode = err.response?.statusCode;

          if (statusCode == 401) {
            // Token invalid or expired → force logout
            SharedPrefHelper.clearAllData();
            NavigationService.navigateToLoginAndClearStack();
          }

          return handler.next(err);
        },
      ),
    );
  }
}
