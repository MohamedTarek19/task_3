import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_3/api/model.dart';
import 'package:task_3/dataCubit/cubit_app_status.dart';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:task_3/main.dart';

class AppCubit extends Cubit<AppState>{
  AppCubit(): super(MyAppInit());

  List<Product>? products = [];
  Future<void> getProductsList() async {
    emit(onPorductLoading());
    Uri url = Uri.parse('https://dummyjson.com/products');
    try{
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body)['products'] as List;
        List<Product>? Products = [];
        for (var b in body) {
          Products.add(Product.fromJson(b));
        }
        products = Products;
        print(products?.length);
        emit(onPorductSuccess());
      }
    }catch(e){
      emit(onPorductError(error: e.toString()));
    }
  }

  Future<void> login(String Email,String Password) async{

      try{
        emit(onLoginLoading());
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: Email,
            password: Password
        );
        if(credential.user != null){
          emit(onLoginSuccess());
        }
      }catch(e){
        emit(onLoginError(error: e.toString()));
      }
    }
  }

