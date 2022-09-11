import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../utils/locator.dart';
import '../constants/app_constants.dart';
import '../../pages/auth/repository/auth_repository.dart';

AuthRepository _authRepository = locator<AuthRepository>();

class PostRequest {
  static Future<dynamic> postWithoutToken({
    required String url,
    Map<String, dynamic>? body,
    required dynamic Function(String) decoder,
  }) async {
    var headers = {
      "Content-Type": "application/json",
    };

    debugPrint(" ");
    debugPrint("POST REQUEST URL: $url");
    debugPrint(" ");
    debugPrint("POST REQUEST BODY: ");
    debugPrint(body.toString());
    debugPrint(" ");

    var request = http.Request('POST', Uri.parse(AppConstants.baseUrl + url));
    request.body = json.encode(body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var res = await response.stream.bytesToString();

    debugPrint("POST RESPONSE BODY: $res");

    debugPrint(" ");
    debugPrint(
        "------------------------------------------------------------------------------------------------------------------------------------------------------------------");
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
