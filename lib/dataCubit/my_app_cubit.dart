import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_3/api/model.dart';
import 'package:task_3/api/personal_data.dart';
import 'package:task_3/dataCubit/cubit_app_status.dart';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:task_3/main.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(MyAppInit());

  List<Product>? products = [];
  List<bool>? flag = [];

  Future<void> getProductsList() async {
    emit(onPorductLoading());
    Uri url = Uri.parse('https://dummyjson.com/products');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body)['products'] as List;
        List<Product>? Products = [];
        for (var b in body) {
          Products.add(Product.fromJson(b));
        }
        products = Products;
        flag =
        List<bool>.filled(products?.length ?? 0, false, growable: true);
        print(products?.length);
        emit(onPorductSuccess());
      }
    } catch (e) {
      emit(onPorductError(error: e.toString()));
    }
  }

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


/*Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) {
                return MyHomePage(
                  title: 'Home',
                );
              }), ModalRoute.withName('/'));



              Center(child: const CircularProgressIndicator());
              */