import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_3/dataCubit/auth_cubit.dart';
import 'package:task_3/dataCubit/cubit_app_status.dart';
import 'package:task_3/dataCubit/my_app_cubit.dart';
import 'package:task_3/main.dart';
import 'package:task_3/view/signup.dart';
import 'package:task_3/widgets/form_field2.dart';
import 'package:task_3/widgets/form_field_template.dart';

class NewSignUpScreen extends StatelessWidget {
  NewSignUpScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  TextEditingController Email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController Phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(

          margin: const EdgeInsets.only(left: 15, right: 15),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Spacer(),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height:40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black)),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios_new_sharp,size: 20,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(

                        margin: const EdgeInsets.only(top: 0),
                        child: const Text(
                          'Welcome back! Glad to see you, Again! ',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(

                      child: Form(
                        key: _formKey,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FormField2Template(
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
                              FormField2Template(
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
                                    } else if (value.contains('@') ==
                                        false &&
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
                    flex:2,
                    child: Container(

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is onSignUpSuccess) {
                              Navigator.of(context)
                                  .pushAndRemoveUntil(
                                  MaterialPageRoute(builder:
                                      (BuildContext
                                  context) {
                                    return MyHomePage(
                                      title: 'Home',
                                    );
                                  }), ModalRoute.withName('/'));
                            } else if (state is onSignUpError) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'SignUp Error:  ${state.error}')),
                              );
                            } else if (state
                            is onCreateAccError) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Creating Account Error:  ${state.error}')),
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
                                      BorderRadius.circular(
                                          10)),
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
                                      .signUp(Email.text,
                                      Password.text,Phone.text,name.text);
                                }
                              },
                              child: state is onSignUpLoading
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
                                  : Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight:
                                    FontWeight.bold),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 5,
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
                                    child:
                                    Text('Or Login with'))),
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
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  height: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.07,
                                  margin:
                                  EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/facebook.png'),
                                          fit:
                                          BoxFit.fitHeight),
                                      borderRadius:
                                      BorderRadius.circular(
                                          10),
                                      border: Border.all(
                                          color: Colors.black)),
                                )),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  height: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.07,
                                  margin:
                                  EdgeInsets.only(right: 0),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/google.png'),
                                          fit:
                                          BoxFit.fitHeight),
                                      borderRadius:
                                      BorderRadius.circular(
                                          10),
                                      border: Border.all(
                                          color: Colors.black)),
                                )),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  height: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.07,
                                  margin:
                                  EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/apple.png'),
                                          fit:
                                          BoxFit.fitHeight),
                                      borderRadius:
                                      BorderRadius.circular(
                                          10),
                                      border: Border.all(
                                          color: Colors.black)),
                                )),
                          ],
                        ),
                      ],
                  ),
                    ),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
