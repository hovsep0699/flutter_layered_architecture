import 'package:core/auth/bloc/auth_event.dart';
import 'package:core/auth/bloc/auth_state.dart';
// login_bloc.dart
import '../auth/bloc/auth.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import './states/login_event.dart';
import './states/login_state.dart';

// class FormProvider extends ChangeNotifier {
//   bool _isValid = true;
//
//   bool get isValid => _isValid;
//
//   void updateTextFieldStatus(bool isValid) {
//     _isValid = isValid;
//     notifyListeners();
//   }
//
//   bool validateUsername(String? username) {
//     return username != null && username.length < 8;
//   }
//
//   bool validatePassword(String? password) {
//     return password != null && password.length < 8;
//   }
// }

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthBloc authBloc;

  LoginBloc({required this.authBloc}) : super(const LoginState()) {
    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onUsernameChanged(UsernameChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      username: event.username,
      isUsernameValid: _isUsernameValid(event.username),
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      password: event.password,
      isPasswordValid: _isPasswordValid(event.password),
    ));
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    if (!state.isUsernameValid || !state.isPasswordValid) {
      emit(state.copyWith(isSubmitting: false, isFailure: true));
      return;
    }
    emit(state.copyWith(isSubmitting: true));
    authBloc.add(
        AuthEvent.login(username: state.username, password: state.password));
    if (authBloc.state.status == AuthStatus.error) {
      emit(state.copyWith(
        isSubmitting: true,
        isSuccess: false,
      ));
    }
    if (authBloc.state.status == AuthStatus.manyTried) {
      emit(state.copyWith(
        isSubmitting: true,
        isSuccess: false,
      ));
    }
    emit(state.copyWith(
      isSubmitting: false,
      isSuccess: true,
    ));
  }

  bool _isUsernameValid(String username) {
    return username.length > 8;
  }

  bool _isPasswordValid(String password) {
    return password.length > 8;
  }
}
