import 'package:bloc/bloc.dart';
import 'package:instagram_clone/pages/profile/repository/profile_repository.dart';
import 'package:meta/meta.dart';

import '../../../../utils/locator.dart';
import '../../model/profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

ProfileRepository _profileRepository = locator<ProfileRepository>();

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<GetProfile>((event, emit) async {
      emit(ProfileLoading());

      final profile = await _profileRepository.getProfile();
      if (profile is Profile) {
        emit(ProfileSuccess(profile: profile));
      } else {
        emit(ProfileFailure(error: profile));
      }
    });

    on<ClearProfile>((event, emit) {
      emit(ProfileInitial());
    });
  }
}
