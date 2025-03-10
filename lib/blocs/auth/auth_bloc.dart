import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/firebase_auth_service.dart';
import '../../services/firestore_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthService _authService;
  final FirestoreService _firestoreService = FirestoreService.instance;

  AuthBloc(this._authService) : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onSignInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authService.signIn(event.email, event.password);
      final user = _authService.currentUser;
      if (user != null) {
        _firestoreService.setCurrentUser(user);
      }
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authService.signUp(event.email, event.password, event.username);
      final user = _authService.currentUser;
      if (user != null) {
        _firestoreService.setCurrentUser(user);
      }
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignOutRequested(
      SignOutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _authService.signOut();
    _firestoreService.clearCurrentUser();
    emit(AuthUnauthenticated());
  }
}
