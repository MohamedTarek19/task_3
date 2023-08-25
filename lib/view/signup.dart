import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_3/dataCubit/auth_cubit.dart';
import 'package:task_3/dataCubit/cubit_app_status.dart';
import 'package:task_3/main.dart';
import 'package:task_3/view/login_screen.dart';
import 'package:task_3/view/first_screen.dart';
import 'package:task_3/widgets/form_field_template.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../dataCubit/my_app_cubit.dart';
import '../firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  TextEditingController Email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController Phone = TextEditingController();
  bool obsecureFlag = true;

  Future<void> signUp(String email, String pass, String phone, String name,
      BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        var cred = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: pass);
        var db;
        if (cred.user != null) {
          try {
            await FirebaseFirestore.instance
                .collection("Users")
                .doc('${cred.user?.uid}')
                .set({
              'name': '${name}',
              'phone': '${phone}',
              'email': '${email}',
              'password': '${pass}',
              'uid': '${cred.user?.uid}'
            }, SetOptions(merge: true));
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (BuildContext context) {
              return MyHomePage(
                title: 'Home',
              );
            }), ModalRoute.withName('/'));
          } catch (e) {
            print(e);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.toString())),
            );
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        flexibleSpace: Container(
          margin: const EdgeInsets.only(top: 60),

          //color: Colors.red,
          child: const Center(
            child: Text(
              'Sign up',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, // <-- SEE HERE
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[100],
      ),
      body: Container(
        width: width,
        margin: const EdgeInsets.only(left: 25, right: 25),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormFieldTemplate(
                      obsecureFlag: false,
                      type: TextInputType.emailAddress,
                      mrgin: 20,
                      controller: name,
                      hintText: 'Name',
                      Validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter your Name';
                        } else if (value.length <= 3) {
                          return 'the Name is too short ';
                        }
                        return null;
                      }),
                  FormFieldTemplate(
                      obsecureFlag: false,
                      type: TextInputType.phone,
                      mrgin: 20,
                      controller: Phone,
                      hintText: 'Phone',
                      Validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter your Phone Number';
                        } else if (value.length <= 3) {
                          return 'the Phone Number is too short ';
                        }
                        return null;
                      }),
                  FormFieldTemplate(
                      obsecureFlag: false,
                      type: TextInputType.emailAddress,
                      mrgin: 20,
                      controller: Email,
                      hintText: 'Email Address',
                      Validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter email';
                        } else if (value.length < 11) {
                          return 'the email is too short ';
                        } else if (value.contains('@') == false &&
                            value.contains('.') == false) {
                          return 'enter a valid email address';
                        }
                        return null;
                      }),
                  StatefulBuilder(
                    builder: (BuildContext context,
                        void Function(void Function()) setState) {
                      return FormFieldTemplate(
                          obsecureFlag: obsecureFlag,
                          iconButton: IconButton(
                            onPressed: () {
                              setState(() {
                                obsecureFlag = !obsecureFlag;
                              });
                            },
                            icon: Icon(obsecureFlag == true
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          type: TextInputType.visiblePassword,
                          mrgin: 40,
                          controller: Password,
                          hintText: 'Password',
                          Validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter password';
                            } else if (value.length <= 3) {
                              return 'the password is too short ';
                            }
                            return null;
                          });
                    },
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is onSignUpSuccess) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return MyHomePage(
                            title: 'Home',
                          );
                        }), ModalRoute.withName('/'));
                      } else if (state is onSignUpError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('SignUp Error:  ${state.error}')),
                        );
                      } else if (state is onCreateAccError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Creating Account Error:  ${state.error}')),
                        );
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 10,
                            minimumSize: Size((width * 0.3), height * 0.06),
                            maximumSize: Size((width * 0.35), height * 0.06),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await context.read<AuthCubit>().signUp(Email.text,
                                Password.text, Phone.text, name.text);
                          }
                        },
                        child: state is onSignUpLoading
                            ? const Padding(
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 35, right: 35),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Icon(Icons.save),
                                  Text('Sign Up'),
                                ],
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
