import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_3/dataCubit/auth_cubit.dart';
import 'package:task_3/dataCubit/cubit_app_status.dart';
import 'package:task_3/dataCubit/my_app_cubit.dart';
import 'package:task_3/helper.dart';
import 'package:task_3/main.dart';
import 'package:task_3/view/new_signup.dart';
import 'package:task_3/view/signup.dart';
import 'package:task_3/widgets/form_field2.dart';
import 'package:task_3/widgets/form_field_template.dart';

class NewLoginScreen extends StatelessWidget {
  NewLoginScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Container(
            //height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Spacer(),
                    Expanded(
                      flex: 1,
                      child: Container(
                          color: Colors.white,
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            'Welcome back! Glad to see you, Again! ',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        color: Colors.white,
                        child: Form(
                          key: _formKey,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                FormField2Template(
                                    obsecureFlag: false,
                                    type: TextInputType.emailAddress,
                                    mrgin: 20,
                                    controller: Email,
                                    hintText: 'Enter your email',
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
                                FormField2Template(
                                    obsecureFlag: true,
                                    type: TextInputType.visiblePassword,
                                    mrgin: 40,
                                    controller: Password,
                                    hintText: 'Enter your password',
                                    Validate: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'please enter password';
                                      } else if (value.length <= 3) {
                                        return 'the password is too short ';
                                      }
                                      return null;
                                    }),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex:3,
                      child: Column(

                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is onLoginSuccess) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((_) {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                        builder: (context) {
                                          return MyHomePage(
                                            title: 'Home',
                                          );
                                        }));
                              });
                            } else if (state is onLoginError) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                    content:
                                    Text(state.error.toString())),
                              );
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  Colors.deepPurple[800],
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  minimumSize: Size(
                                      MediaQuery.of(context)
                                          .size
                                          .width,
                                      MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.08)),
                              onPressed: () async {
                                if (_formKey.currentState!
                                    .validate()) {
                                  await context
                                      .read<AuthCubit>()
                                      .login(
                                      Email.text, Password.text);

                                }
                              },
                              child: state is onLoginLoading
                                  ? const Padding(
                                padding: EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                    left: 35,
                                    right: 35),
                                child: Center(
                                  child:
                                  CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                                  : Text('login',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            );
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.02,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Divider(
                                  height: 1,
                                  color: Colors.blue[100],
                                  thickness: 1,
                                )),
                            Expanded(
                                flex: 3,
                                child: Center(
                                    child: Text('Or Login with'))),
                            Expanded(
                                flex: 2,
                                child: Divider(
                                  height: 1,
                                  color: Colors.blue[100],
                                  thickness: 1,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.05,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.07,

                                  margin: EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage('assets/images/facebook.png'),fit: BoxFit.fitHeight),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.black)),
                                )),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.07,
                                  margin: EdgeInsets.only(right: 0),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage('assets/images/google.png'),fit: BoxFit.fitHeight),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.black)),
                                )),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.07,
                                  margin: EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage('assets/images/apple.png'),fit: BoxFit.fitHeight),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.black)),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?',style: TextStyle(fontSize: 16),),
                            InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                    return NewSignUpScreen();
                                  }));

                                },
                                child: Text(' Register now',style: TextStyle(color: Colors.red,fontSize: 16),))
                          ],
                        )
                      ],
                    ),)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
