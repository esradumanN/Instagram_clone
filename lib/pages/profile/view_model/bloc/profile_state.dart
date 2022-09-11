part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final Profile profile;

  ProfileSuccess({required this.profile});
}

class ProfileFailure extends ProfileState {
  final String error;

  ProfileFailure({
    required this.error,
  });
}
