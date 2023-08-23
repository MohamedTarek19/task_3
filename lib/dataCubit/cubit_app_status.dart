abstract class AppState{
}

class MyAppInit extends AppState{}

class onPorductLoading extends AppState{}
class onPorductSuccess extends AppState{}
class onPorductError extends AppState{
  onPorductError({required this.error});
  String error;
}

class onLoginLoading extends AppState{}
class onLoginSuccess extends AppState{}
class onLoginError extends AppState{
  onLoginError({required this.error});
  String error;
}

class onSignUpLoading extends AppState{}
class onSignUpSuccess extends AppState{}
class onCreateAccError extends AppState{
  onCreateAccError({required this.error});
  String error;
}
class onSignUpError extends AppState{
  onSignUpError({required this.error});
  String error;
}



