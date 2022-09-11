// To parse this JSON data, do
//
//     final story = storyFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Story storyFromJson(String str) => Story.fromJson(json.decode(str));

String storyToJson(Story data) => json.encode(data.toJson());

class Story {
  Story({
    required this.type,
    required this.message,
    required this.data,
  });

  bool type;
  String message;
  Data data;

  factory Story.fromJson(Map<String, dynamic> json) => Story(
        type: json["type"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.stories,
  });

  List<StoryElement> stories;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        stories: List<StoryElement>.from(
            json["stories"].map((x) => StoryElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "stories": List<dynamic>.from(stories.map((x) => x.toJson())),
      };
}

class StoryElement {
  StoryElement({
    required this.id,
    required this.images,
    required this.profilePhoto,
    required this.username,
  });

  int id;
  List<String> images;
  String profilePhoto;
  String username;

  factory StoryElement.fromJson(Map<String, dynamic> json) => StoryElement(
        id: json["id"],
        images: List<String>.from(json["images"].map((x) => x)),
        profilePhoto: json["profile_photo"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "images": List<dynamic>.from(images.map((x) => x)),
        "profile_photo": profilePhoto,
        "username": username,
      };
}
