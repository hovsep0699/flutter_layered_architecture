import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';
part 'auth_state.g.dart';

enum ErrorType { manyTried, error }

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState(
      {required AuthStatus status,
      String? message,
      ErrorType? type}) = _AuthState;
  factory AuthState.initial() => const AuthState(status: AuthStatus.initial);
  factory AuthState.loading() => const AuthState(status: AuthStatus.loading);
  factory AuthState.authenticated() =>
      const AuthState(status: AuthStatus.initial);
  factory AuthState.unauthenticated() =>
      const AuthState(status: AuthStatus.unauthenticated);
  factory AuthState.manyTried({required String message}) => AuthState(
      status: AuthStatus.manyTried,
      message: message,
      type: ErrorType.manyTried);
  factory AuthState.logout() => const AuthState(status: AuthStatus.logout);
  factory AuthState.error({required String message}) => AuthState(
      status: AuthStatus.error, message: message, type: ErrorType.error);
  factory AuthState.fromJson(Map<String, Object?> json) =>
      _$AuthStateFromJson(json);
}
//
// // abstract class AuthState extends Equatable {
// //   @override
// //   List<Object> get props => [];
// // }
//
// class AuthInitial extends AuthState {}
//
// class AuthLoading extends AuthState {}
//
// class AuthAuthenticated extends AuthState {}
//
// class AuthManyTried extends AuthState {}
//
// class AuthUnauthenticated extends AuthState {}
//
// class AuthError extends AuthState {
//   final String message;
//
//   AuthError(this.message);
//
//   @override
//   List<Object> get props => [message];
// }

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  manyTried,
  error,
  logout
}
