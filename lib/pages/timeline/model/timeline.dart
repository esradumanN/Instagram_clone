// To parse this JSON data, do
//
//     final timeline = timelineFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Timeline timelineFromJson(String str) => Timeline.fromJson(json.decode(str));

String timelineToJson(Timeline data) => json.encode(data.toJson());

class Timeline {
  Timeline({
    required this.type,
    required this.message,
    required this.data,
  });

  bool type;
  String message;
  Data data;

  factory Timeline.fromJson(Map<String, dynamic> json) => Timeline(
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
    required this.timeline,
  });

  List<TimelineElement> timeline;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        timeline: List<TimelineElement>.from(
            json["timeline"].map((x) => TimelineElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "timeline": List<dynamic>.from(timeline.map((x) => x.toJson())),
      };
}

class TimelineElement {
  TimelineElement({
    required this.id,
    required this.username,
    required this.location,
    required this.description,
    required this.images,
    required this.likes,
  });

  int id;
  String username;
  String location;
  String description;
  List<TimelineImage> images;
  List<String> likes;

  factory TimelineElement.fromJson(Map<String, dynamic> json) =>
      TimelineElement(
        id: json["id"],
        username: json["username"],
        location: json["location"],
        description: json["description"],
        images: List<TimelineImage>.from(
            json["images"].map((x) => TimelineImage.fromJson(x))),
        likes: List<String>.from(json["likes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "location": location,
        "description": description,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "likes": List<dynamic>.from(likes.map((x) => x)),
      };
}

class TimelineImage {
  TimelineImage({
    required this.id,
    required this.url,
  });

  int id;
  String url;

  factory TimelineImage.fromJson(Map<String, dynamic> json) => TimelineImage(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}
