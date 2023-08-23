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
      margin: const EdgeInsets.only(top: 20,left: 15, right: 15,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(10),
                        margin: const EdgeInsets.only(left: 0, right: 5),
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              '${title}  ${textval}',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ))))),
          ),
        ],
      ),
    );
  }
}
