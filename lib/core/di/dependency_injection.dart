import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mediops/core/networks/api_services.dart';
import 'package:mediops/core/networks/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setUpGetIt() async {
  Dio dio =  DioFactory.getDio();

  //Dio & ApiService
  getIt.registerLazySingleton<ApiService>(()=>ApiService(dio));
  
  }