import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_3/widgets/profile_item.dart';

class Profile extends StatefulWidget {
 Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user = FirebaseAuth.instance.currentUser;
  DocumentSnapshot? userData;
  Map<String,dynamic>? data;
  bool isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((value) async {
      userData =  await FirebaseFirestore.instance.collection('Users').doc('${user?.uid}').get();
      setState(() {
        if(userData != null){
          data = userData?.data() as Map<String,dynamic>;
          isLoading = true;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading? Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
            Container(
              height: MediaQuery.of(context).size.height*0.2,
              width: MediaQuery.of(context).size.height*0.2,
              decoration: const BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: AssetImage('assets/images/avatar.jpg'),
                ),
                shape: BoxShape.circle
              ),
            ),
            TextView(textval: data?['name'],title: 'Name:',),
            TextView(textval: data?['phone'],title: 'Phone Number:',),
            TextView(textval: data?['email'],title: 'Email:',),
          ],
        ),
      ),
    ): CircularProgressIndicator();
  }
}
