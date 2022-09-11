import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/pages/auth/repository/auth_service.dart';
import 'package:instagram_clone/pages/story/model/story.dart';
import 'package:instagram_clone/pages/story/repository/story_service.dart';
import 'package:instagram_clone/utils/locator.dart';

class StoryRepository {
  final StoryService _storyService = locator<StoryService>();
  Story? story;

  Future<dynamic> getStory() async {
    try {
      var response = await _storyService.getStory();

      if (response is Story) {
        story = response;
      }
      return response;
    } catch (e) {
      debugPrint("GetStory catch, error: $e");
      return e;
    }
  }

  clear() {
    story = null;
  }
}
