import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../utils/locator.dart';
import '../constants/app_constants.dart';
import '../../pages/auth/repository/auth_repository.dart';

AuthRepository _authRepository = locator<AuthRepository>();

class GetRequest {
  static Future<dynamic> get({
    required String url,
    required dynamic Function(String) decoder,
  }) async {
    var headers = {
      "Content-Type": "application/json",
      "Authorization": _authRepository.auth!.data.token,
      'token': _authRepository.auth!.data.token,
    };
    debugPrint(" ");

    debugPrint("GET REQUEST URL: $url");
    debugPrint(" ");

    var request = http.Request('GET', Uri.parse(AppConstants.baseUrl + url));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    var res = await response.stream.bytesToString();

    debugPrint("GET RESPONSE BODY: $res");

    debugPrint(" ");
    debugPrint(
        "-------------------------------------------------------------------------------------------------------------------------------------------------------------");
    if (response.statusCode == 200) {
      try {
        return decoder(res);
      } catch (e) {
        debugPrint("Error At: $url");
        debugPrint("Error At: $e");
      }
    } else {
      return jsonDecode(res)["message"];
    }
  }
}
