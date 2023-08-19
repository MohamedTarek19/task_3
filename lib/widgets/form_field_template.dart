import 'package:flutter/material.dart';

class FormFieldTemplate extends StatelessWidget {
  FormFieldTemplate({
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
      child: Material(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              obscureText: obsecureFlag,
              keyboardType: type,
              validator: Validate,
              controller: controller,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                suffixIcon: iconButton,
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: hintText,
              ),
            )),
      ),
    );
  }
}