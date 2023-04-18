import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoadingState());
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(LoginSuccessState());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            emit(LoginFailureState(errorMessage: 'weak-password'));
          } else if (e.code == 'user-not-found') {
            emit(LoginFailureState(errorMessage: 'user not found'));
          }
        } catch (e) {
          emit(LoginFailureState(errorMessage: 'something wrong'));
        }
      }
    });
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
