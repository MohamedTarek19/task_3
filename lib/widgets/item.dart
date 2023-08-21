import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  Item(
      {Key? key,
        required this.itemPath,
        required this.itemName,
        required this.itemDesc,
        required this.itemPrice,
        required this.itemfav
      })
      : super(key: key);
  bool itemfav;
  String? itemName;
  double? itemPrice;
  String? itemDesc;
  String? itemPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin:
          const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 0),
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.164,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.19,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Image.network(
                      itemPath ?? '',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 10,top: 7),
                  child: Icon(
                    itemfav?Icons.favorite:Icons.favorite_outline,
                    color: Colors.red,
                  )),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.16 * 0.65,
                  child: Container(
                    padding: const EdgeInsets.only(left: 5,right: 5),
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.04,
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                    ),
                    child: Center(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              itemName ?? '',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ))),
                  )),
            ],
          ),
        ),
        Container(
          height: 70,
          width: MediaQuery.of(context).size.width * 0.5,
          margin: const EdgeInsets.only(
              left: 5, right: 5, bottom: 0, top: 10),
          child: Column(
            children: [
              Container(
                  child: SizedBox(
                    height: 47,
                    child: SingleChildScrollView(
                        child: Text(
                          itemDesc ?? '',
                          style: const TextStyle(fontSize: 15, color: Colors.grey),
                        )),
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 2),
                  child: Text(
                    "${itemPrice.toString()} \$",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        )
      ],
    );

  }
}