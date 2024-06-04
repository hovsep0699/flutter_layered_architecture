import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String username;
  final String password;

  LoggedIn(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

class LoggedOut extends AuthEvent {}
