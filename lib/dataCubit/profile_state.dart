part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class onGettingDataLoading extends ProfileState{}
class onGettingDataSuccess extends ProfileState{}
class onGettingDataError extends ProfileState{
  onGettingDataError({required this.error});
  String error;
}

class PickImageSuccess extends ProfileState {}
class PickImageLoading extends ProfileState {}
