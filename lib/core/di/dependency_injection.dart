import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mediops/core/networks/api_services.dart';
import 'package:mediops/core/networks/dio_factory.dart';
import 'package:mediops/features/login/data/repos/login_repo.dart';
import 'package:mediops/features/login/logic/cubit/login_cubit.dart';
import 'package:mediops/features/register/data/repos/client_register_repo.dart';
import 'package:mediops/features/register/data/repos/doctor_register_repo.dart';
import 'package:mediops/features/register/data/repos/clinic_register_repo.dart';
import 'package:mediops/features/register/logic/cubit/client_register_cubit.dart';
import 'package:mediops/features/register/logic/cubit/doctor_register_cubit.dart';
import 'package:mediops/features/register/logic/cubit/clinic_register_cubit.dart';

final getIt = GetIt.instance;

Future<void> setUpGetIt() async {
  Dio dio =  DioFactory.getDio();

  //Dio & ApiService
  getIt.registerLazySingleton<ApiService>(()=>ApiService(dio));

  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  getIt.registerLazySingleton<ClinicRegisterRepo>(() => ClinicRegisterRepo(getIt()));
  getIt.registerFactory<ClinicRegisterCubit>(() => ClinicRegisterCubit(getIt()));

  getIt.registerLazySingleton<DoctorRegisterRepo>(() => DoctorRegisterRepo(getIt()));
  getIt.registerFactory<DoctorRegisterCubit>(() => DoctorRegisterCubit(getIt()));

  getIt.registerLazySingleton<ClientRegisterRepo>(() => ClientRegisterRepo(getIt()));
  getIt.registerFactory<ClientRegisterCubit>(() => ClientRegisterCubit(getIt()));
  
  }
