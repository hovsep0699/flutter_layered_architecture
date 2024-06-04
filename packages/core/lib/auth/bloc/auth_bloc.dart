import 'package:bloc/bloc.dart';
import 'package:core/auth/bloc/auth_event.dart';
import 'package:core/auth/bloc/auth_state.dart';
import 'package:equatable/equatable.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }
  int counter = 0;
  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // Simulate a delay for checking authentication status
    await Future.delayed(const Duration(seconds: 2));
    // Check if the user is authenticated or not (e.g., check a token)
    bool isAuthenticated = false; // Replace with your authentication logic
    if (isAuthenticated) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) {
    // Here you can check the provided username and password
    // against your authentication system
    if (event.username == 'administrator' &&
        event.password == 'administrator') {
      emit(AuthAuthenticated());
    } else {
      ++counter;

      emit(AuthError('Մուտքային տվյալները սխալ են լրացված'));
    }
  }

  void _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) {
    emit(AuthUnauthenticated());
  }
}
