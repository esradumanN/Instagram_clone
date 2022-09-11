import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../core/config/post_request.dart';

import '../../../core/constants/app_constants.dart';
import '../model/user_model.dart';

class AuthService {
  Future<dynamic> getAuth(
      {required String email, required String password}) async {
    return PostRequest.postWithoutToken(
      url: AppConstants.authLogin,
      decoder: userModelFromJson,
      body: {
        "username": email,
        "password": password,
      },
    );
  }
}
