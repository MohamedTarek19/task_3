import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:task_3/api/personal_data.dart';
import 'package:task_3/helper.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  User? user = FirebaseAuth.instance.currentUser;

  UserDataModel? Data;


  Future<void> GetData() async{

      print('in get data');
      String? uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot? userData;
      try {
        print('#########################getting Data#########################');
        emit(onGettingDataLoading());
        print('###############${onGettingDataLoading()}##################');
        userData = await FirebaseFirestore.instance
            .collection('Users')
            .doc('${uid}')
            .get();
        if (userData != null) {
          Data = UserDataModel(
              name: userData['name'],
              password: userData['password'],
              phone: userData['phone'],
              email: userData['email'],
              uid: userData['uid'],
              image: userData['image']);
          print('###############${Data?.name}##################');

          emit(onGettingDataSuccess());
          print('###############${onGettingDataSuccess()}##################');
        }
      } catch (e) {
        print(
            '###############${onGettingDataError(error: e.toString())}##################');
        emit(onGettingDataError(error: e.toString()));
      }

  }

  ImagePicker picker = ImagePicker();
  File? img;

  Future<void> pickImage() async {
    try{
      emit(PickImageLoading());
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        img = File(image.path);
        await uploadImageToUserData(File(image.path));
        print('######################[${img}]##################');
        emit(PickImageSuccess());
      } else {
        emit(PickWithNull());
        print('null image');
      }
    }catch(e){

    }

  }

  Future<void> uploadImageToUserData(File image) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      final ref = FirebaseStorage.instance
          .ref()
          .child('usersImages')
          .child('${DateTime.now()}.jpg');

      await ref.putFile(File(image.path));

      String? url;

      url = await ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('Users').doc(uid).update(
        {
          'image': url,
        },
      );
    } catch (e) {

    }
  }
}
