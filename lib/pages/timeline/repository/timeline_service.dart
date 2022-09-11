import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:instagram_clone/core/config/get_request.dart';
import 'package:instagram_clone/pages/timeline/model/timeline.dart';

import '../../../core/config/post_request.dart';

import '../../../core/constants/app_constants.dart';

class TimelineService {
  Future<dynamic> getTimeline() async {
    return GetRequest.get(
      url: AppConstants.timeline,
      decoder: timelineFromJson,
    );
  }
}
