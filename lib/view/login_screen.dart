import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_3/dataCubit/cubit_app_status.dart';
import 'package:task_3/dataCubit/my_app_cubit.dart';
import 'package:task_3/main.dart';
import 'package:task_3/view/first_screen.dart';
import 'package:task_3/view/signup.dart';
import 'package:task_3/widgets/form_field_template.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  bool obsecureFlag = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, // <-- SEE HERE
        ),
        centerTitle: true,
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.grey[100],
        title: const Center(
          child: Text(
            'Login',
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
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
                      iconButton: const Icon(Icons.email),
                      obsecureFlag: false,
                      type: TextInputType.emailAddress,
                      mrgin: 20,
                      controller: Email,
                      hintText: 'Email Address',
                      Validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter email';
                        } else if (value.length <= 3) {
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
                  BlocConsumer<AppCubit, AppState>(
                    listener: (context, state) {
                      if (state is onLoginSuccess) {
                        WidgetsBinding.instance.addPostFrameCallback((_){
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                                return MyHomePage(title: 'Home',);
                              }));
                        });
                      } else if (state is onLoginError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error.toString())),
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
                            await context
                                .read<AppCubit>()
                                .login(Email.text, Password.text);
                          }
                        },
                        child: state is onLoginLoading
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
                                  Icon(Icons.login),
                                  Text('login'),
                                ],
                              ),
                      );
                    },
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  const Text(
                    'Or u can just',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 10,
                        minimumSize: Size((width * 0.3), height * 0.06),
                        maximumSize: Size((width * 0.35), height * 0.9),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return SignUp();
                      }));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(Icons.save),
                        Text('Sign Up'),
                      ],
                    ),
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
