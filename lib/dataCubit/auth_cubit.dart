import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());



  Future<void> login(String Email, String Password) async {
    try {
      emit(onLoginLoading());
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: Email, password: Password);
      if (credential.user != null) {
        emit(onLoginSuccess());

      }
    } catch (e) {
      emit(onLoginError(error: e.toString()));
    }
  }


  Future<void> signUp(String email, String pass, String phone, String name) async {
    try {
      emit(onSignUpLoading());

      var cred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      var db;
      if (cred.user != null) {
        try {
          await FirebaseFirestore.instance
              .collection("Users")
              .doc('${cred.user?.uid}')
              .set({
            'name': '${name}',
            'phone': '${phone}',
            'email': '${email}',
            'password': '${pass}',
            'uid': '${cred.user?.uid}',
            'image': '',
          }, SetOptions(merge: true));
          emit(onSignUpSuccess());

        } catch (e) {
          emit(onSignUpError(error: e.toString()));
        }

      }
    } catch (e) {
      emit(onCreateAccError(error: e.toString()));
    }
  }
}
