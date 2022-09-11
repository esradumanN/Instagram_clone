import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/pages/auth/repository/auth_service.dart';
import 'package:instagram_clone/pages/profile/repository/profile_service.dart';
import 'package:instagram_clone/pages/profile/model/profile.dart';
import 'package:instagram_clone/pages/timeline/repository/timeline_service.dart';
import 'package:instagram_clone/utils/locator.dart';

import '../model/profile.dart';

class ProfileRepository {
  final ProfileService _profileService = locator<ProfileService>();
  Profile? profile;

  Future<dynamic> getProfile() async {
    try {
      var response = await _profileService.getProfile();

      if (response is Profile) {
        profile = response;
      }
      return response;
    } catch (e) {
      debugPrint("GetProfile catch, error: $e");
      return e;
    }
  }

  clear() {
    profile = null;
  }
}
