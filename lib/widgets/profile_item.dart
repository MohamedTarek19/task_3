import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  TextView({
    Key? key,
    required this.textval,
    required this.title,
  }) : super(key: key);

  String title;
  String textval;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(
            height: 5,
          ),
          Material(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              textval,
                              style: TextStyle(
                                  fontSize: 25, color: Colors.grey[700]),
                            ))))),
          ),
        ],
      ),
    );
  }
}
