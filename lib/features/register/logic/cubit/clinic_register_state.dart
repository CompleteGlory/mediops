import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_register_state.freezed.dart';

@freezed
class ClinicRegisterState<T> with _$ClinicRegisterState<T> {
  const factory ClinicRegisterState.initial() = _Initial;
  const factory ClinicRegisterState.loading() = _Loading;
  const factory ClinicRegisterState.success(T data) = _Success<T>;
  const factory ClinicRegisterState.failure(String message) = _Failure;
}
