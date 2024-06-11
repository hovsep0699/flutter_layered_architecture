import 'dart:async';

import 'package:core/auth/bloc/auth_event.dart';
import 'package:core/auth/bloc/auth_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  AuthBloc({required this.authService}) : super(AuthState.initial()) {
    on<AuthStarted>(_onAppStarted);
    on<AuthLogin>(_onLoggedIn);
    on<AuthLogout>(_onLoggedOut);
  }
  int counter = 0;
  bool isOpen = true;
  Future<void> _onAppStarted(AuthStarted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // Simulate a delay for checking authentication status
    // await Future.delayed(const Duration(seconds: 2));
    // Check if the user is authenticated or not (e.g., check a token)
    await authService.loadFromPrefs();
    bool isAuthenticated =
        authService.isAuthorized; // Replace with your authentication logic
    if (isAuthenticated) {
      emit(state.copyWith(status: AuthStatus.authenticated));
    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  Future<void> _onLoggedIn(AuthLogin event, Emitter<AuthState> emit) async {
    if (!isOpen) {
      emit(state.copyWith(
          status: AuthStatus.manyTried,
          message: "Ձեր տվյալները մուտք են արվել թույլատրելի քանակից շատ"));
    }
    // Here you can check the provided username and password
    // against your authentication system

    await authService.login(event.username, event.password);
    // print("object $token");
    // await authService.saveToPrefs(token);

    bool isAuthenticated = authService.isAuthorized;
    if (isAuthenticated) {
      emit(state.copyWith(status: AuthStatus.authenticated));
    } else {
      ++counter;
      if (counter >= 3) {
        isOpen = false;
        emit(state.copyWith(
            status: AuthStatus.manyTried,
            message: "Ձեր տվյալները մուտք են արվել թույլատրելի քանակից շատ"));
        Future.microtask(() {
          const duration = Duration(seconds: 50); // Reset after 5 minutes
          Timer(duration, () {
            // When timer expires, set isOpen to true
            isOpen = true;
            counter = 0;
          });
        });
      }
      if (isOpen) {
        emit(state.copyWith(
            status: AuthStatus.error,
            message: 'Մուտքային տվյալները սխալ են լրացված'));
      }
    }

    // emit(state.copyWith());
    if (kDebugMode) {
      print("auth: $state");
    }
  }

  Future<void> _onLoggedOut(AuthLogout event, Emitter<AuthState> emit) async {
    await authService.logout();
    emit(state.copyWith(status: AuthStatus.unauthenticated));
  }
}
