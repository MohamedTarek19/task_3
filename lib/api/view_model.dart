import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:task_3/api/model.dart';
class ProductVm{

  Future<List<Product>?> getProductsList() async {
    Uri url = Uri.parse('https://dummyjson.com/products');

    var response = await http.get(url);
    if(response.statusCode == 200){
      //print("${response.body}\n");
      var body = jsonDecode(response.body)['products'] as List;
      List<Product>? todoList = [];
      for(var b in body){
        // print(b.key);
        todoList.add(Product.fromJson(b));
        //print(b);
      }
      return todoList;
    }
    return null;
  }

}