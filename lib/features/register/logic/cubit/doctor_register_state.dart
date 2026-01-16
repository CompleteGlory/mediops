import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor_register_state.freezed.dart';

@freezed
class DoctorRegisterState<T> with _$DoctorRegisterState<T> {
  const factory DoctorRegisterState.initial() = _Initial;
  const factory DoctorRegisterState.loading() = _Loading;
  const factory DoctorRegisterState.success(T data) = _Success<T>;
  const factory DoctorRegisterState.failure(String message) = _Failure;
}
