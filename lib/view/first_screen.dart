import 'package:flutter/material.dart';
import 'package:task_3/helper.dart';
import 'package:task_3/widgets/item.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: Helper.products?.length,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (MediaQuery.of(context).size.width * 0.5) /
              (MediaQuery.of(context).size.height * 0.3)),
      itemBuilder: (BuildContext context, int index) {
        return Container(
            margin: const EdgeInsets.only(top: 10),
            //color: Colors.white,
            child: Item(
              itemName: Helper.products?[index].title,
              itemDesc: Helper.products?[index].description,
              itemPrice: Helper.products?[index].price?.toDouble(),
              itemPath: Helper.products?[index].thumbnail,
            ));
      },
    );
  }
}