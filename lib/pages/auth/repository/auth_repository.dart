import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/pages/auth/repository/auth_service.dart';
import 'package:instagram_clone/utils/locator.dart';
import '../model/user_model.dart';

class AuthRepository {
  final AuthService _authService = locator<AuthService>();
  UserModel? auth;

  Future<dynamic> getAuth({
    required String email,
    required String password,
  }) async {
    try {
      var response = await _authService.getAuth(
        email: email,
        password: password,
      );

      if (response is UserModel) {
        auth = response;
      }
      return response;
    } catch (e) {
      debugPrint("GetAuth catch, error: $e");
      return e;
    }
  }

  clear() {
    auth = null;
  }
}
