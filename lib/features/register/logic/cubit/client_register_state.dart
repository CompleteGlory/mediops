import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_register_state.freezed.dart';

@freezed
class ClientRegisterState<T> with _$ClientRegisterState<T> {
  const factory ClientRegisterState.initial() = _Initial;
  const factory ClientRegisterState.loading() = _Loading;
  const factory ClientRegisterState.success(T data) = _Success<T>;
  const factory ClientRegisterState.failure(String message) = _Failure;
}
