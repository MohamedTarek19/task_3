import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_3/dataCubit/cubit_app_status.dart';
import 'package:task_3/dataCubit/my_app_cubit.dart';
import 'package:task_3/dataCubit/profile_cubit.dart';
import 'package:task_3/widgets/profile_item.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) async {
            print(context.read<ProfileCubit>().Data?.image.isEmpty);
          },
          builder: (context, state) {
            print(" state is ${state}");
            if (state is onGettingDataLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is onGettingDataSuccess ||
                state is PickImageSuccess || state is PickWithNull?) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.22,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.21,
                        width: MediaQuery.of(context).size.height * 0.21,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            shape: BoxShape.circle),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: (state is PickImageSuccess)
                                  ? (FileImage(context.read<ProfileCubit>().img!))
                                  : (context.read<ProfileCubit>().Data?.image != '' || context.read<ProfileCubit>().Data?.image != null)
                                      ? const AssetImage('assets/images/avatar.jpg',) as ImageProvider:NetworkImage(context.read<ProfileCubit>().Data?.image ?? ''),
                            ),
                            shape: BoxShape.circle),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.15,
                        right: MediaQuery.of(context).size.height * 0.14,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            color: Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: IconButton(
                              icon: const Icon(Icons.add_a_photo_outlined),
                              onPressed: () async {
                                await context.read<ProfileCubit>().pickImage();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextView(
                    textval: context.read<ProfileCubit>().Data?.name ?? '',
                    title: 'Name:',
                  ),
                  TextView(
                    textval: context.read<ProfileCubit>().Data?.phone ?? '',
                    title: 'Phone Number:',
                  ),
                  TextView(
                    textval: context.read<ProfileCubit>().Data?.email ?? '',
                    title: 'Email:',
                  ),
                ],
              );
            } else {
              // return Center(
              //   child: Text(
              //     'there is error !!!!!{ state is ${state} }',
              //     style: const TextStyle(
              //         fontWeight: FontWeight.bold, fontSize: 30),
              //   ),
              // );
              return Center(child: CircularProgressIndicator(),);
            }
          },
        ),
      ),
    );
  }
}
