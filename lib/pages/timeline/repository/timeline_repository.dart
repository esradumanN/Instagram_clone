import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/pages/auth/repository/auth_service.dart';
import 'package:instagram_clone/pages/timeline/model/timeline.dart';
import 'package:instagram_clone/pages/timeline/repository/timeline_service.dart';
import 'package:instagram_clone/utils/locator.dart';

class TimelineRepository {
  final TimelineService _timelineService = locator<TimelineService>();
  Timeline? timeline;

  Future<dynamic> getTimeline() async {
    try {
      var response = await _timelineService.getTimeline();

      if (response is Timeline) {
        timeline = response;
      }
      return response;
    } catch (e) {
      debugPrint("GetTimeline catch, error: $e");
      return e;
    }
  }

  clear() {
    timeline = null;
  }
}
