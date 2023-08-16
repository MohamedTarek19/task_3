import 'package:task_3/api/model.dart';
import 'package:task_3/api/view_model.dart';

class Helper{
  static List<Product>? products = [];
  static bool flag = false;

  static Future<void> GetData() async {
    ProductVm prod_vm = ProductVm();
    products = await prod_vm.getProductsList();
  }


}