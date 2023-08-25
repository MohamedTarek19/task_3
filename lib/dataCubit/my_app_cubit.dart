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



}


/*Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) {
                return MyHomePage(
                  title: 'Home',
                );
              }), ModalRoute.withName('/'));



              Center(child: const CircularProgressIndicator());
              */