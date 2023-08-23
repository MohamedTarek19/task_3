import 'package:flutter/material.dart';

class FormField2Template extends StatelessWidget {
  FormField2Template({
    super.key,
    required this.controller,
    required this.hintText,
    required this.Validate,
    required this.mrgin,
    required this.type,
    required this.obsecureFlag,
    this.iconButton,

  });
  String hintText;
  TextEditingController controller;
  String? Function(String?)? Validate;
  double mrgin;
  TextInputType type;
  Widget? iconButton;
  bool obsecureFlag;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: mrgin),
      child: Container(
        padding: EdgeInsets.only(left: 15,top: 5),
        height: MediaQuery.of(context).size.height*0.08,
          decoration: BoxDecoration(
              color: Color.fromRGBO(249, 249, 249, 1),
              borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color.fromRGBO(210, 210, 222, 1))
          ),
          child: Center(
            child: TextFormField(
              obscureText: obsecureFlag,
              keyboardType: type,
              validator: Validate,
              controller: controller,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                suffixIcon: iconButton,
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: hintText,
              ),
            ),
          )),
    );
  }
}