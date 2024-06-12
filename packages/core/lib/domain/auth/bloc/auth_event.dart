import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
abstract class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = AuthStarted;
  const factory AuthEvent.login(
      {required String username, required String password}) = AuthLogin;
  const factory AuthEvent.logout() = AuthLogout;
}

// class AppStarted extends AuthEvent {}
//
// class LoggedIn extends AuthEvent {
//   final String username;
//   final String password;
//
//   LoggedIn(this.username, this.password);
//
//   @override
//   List<Object> get props => [username, password];
// }
//
// class LoggedOut extends AuthEvent {}
