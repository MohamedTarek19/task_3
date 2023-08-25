part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class onLoginLoading extends AuthState{}
class onLoginSuccess extends AuthState{}
class onLoginError extends AuthState{
  onLoginError({required this.error});
  String error;
}

class onSignUpLoading extends AuthState{}
class onSignUpSuccess extends AuthState{}
class onCreateAccError extends AuthState{
  onCreateAccError({required this.error});
  String error;
}
class onSignUpError extends AuthState{
  onSignUpError({required this.error});
  String error;
}