abstract class AppState{
}

class MyAppInit extends AppState{}

class onPorductLoading extends AppState{}
class onPorductSuccess extends AppState{}
class onPorductError extends AppState{
  onPorductError({required this.error});
  String error;
}





