part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class LoginSuccessState extends AuthState {}
class LoginLoadingState extends AuthState {}
class LoginFailureState extends AuthState {
  String errorMessage;
  LoginFailureState({required this.errorMessage});
}
