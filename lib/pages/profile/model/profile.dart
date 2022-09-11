// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    required this.type,
    required this.message,
    required this.data,
  });

  bool type;
  String message;
  Data data;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
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
    required this.username,
    required this.name,
    required this.surname,
    required this.fullName,
    required this.profileText,
    required this.profilePhoto,
    required this.highlights,
    required this.posts,
  });

  String username;
  String name;
  String surname;
  String fullName;
  String profileText;
  String profilePhoto;
  List<Highlight> highlights;
  List<Post> posts;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        username: json["username"],
        name: json["name"],
        surname: json["surname"],
        fullName: json["full_name"],
        profileText: json["profile_text"],
        profilePhoto: json["profile_photo"],
        highlights: List<Highlight>.from(
            json["highlights"].map((x) => Highlight.fromJson(x))),
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "surname": surname,
        "full_name": fullName,
        "profile_text": profileText,
        "profile_photo": profilePhoto,
        "highlights": List<dynamic>.from(highlights.map((x) => x.toJson())),
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
      };
}

class Highlight {
  Highlight({
    required this.id,
    required this.url,
  });

  int id;
  String url;

  factory Highlight.fromJson(Map<String, dynamic> json) => Highlight(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}

class Post {
  Post({
    required this.id,
    required this.description,
    required this.images,
  });

  int id;
  String description;
  List<Highlight> images;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        description: json["description"],
        images: List<Highlight>.from(
            json["images"].map((x) => Highlight.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}
