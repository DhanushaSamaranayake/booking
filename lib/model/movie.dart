import 'dart:convert';

import 'package:flutter/foundation.dart';

class MovieModel {
  final String title;
  final String time;
  final String name;
  final String image;
  final String namee;
  final String imagee;
  final String busNumber;
  final String description;
  final List<String> actors;
  final int like;
  final String bannerUrl;
  final List<String> screens;

  MovieModel({
    required this.title,
    required this.time,
    required this.name,
    required this.image,
    required this.namee,
    required this.imagee,
    required this.busNumber,
    required this.description,
    required this.actors,
    required this.like,
    required this.bannerUrl,
    this.screens = const [
      "3D",
      "2D",
    ],
  });

  MovieModel copyWith({
    String? title,
    String? time,
    String? name,
    String? image,
    String? namee,
    String? imagee,
    String? busNumber,
    String? description,
    List<String>? actors,
    int? like,
    String? bannerUrl,
    List<String>? screens,
  }) {
    return MovieModel(
      title: title ?? this.title,
      time: time ?? this.time,
      name: name ?? this.name,
      image: image ?? this.image,
      namee: namee ?? this.namee,
      imagee: imagee ?? this.imagee,
      busNumber: busNumber ?? this.busNumber,
      description: description ?? this.description,
      actors: actors ?? this.actors,
      like: like ?? this.like,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      screens: screens ?? this.screens,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title1': time,
      'title': title,
      'name': name,
      'image': image,
      'namee': namee,
      'imagee': imagee,
      'busNumber': busNumber,
      'description': description,
      'actors': actors,
      'like': like,
      'bannerUrl': bannerUrl,
      'screens': screens,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      title: map['title'] ?? '',
      time: map['time'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      namee: map['namee'] ?? '',
      imagee: map['imagee'] ?? '',
      busNumber: map['busNumber'] ?? '',
      description: map['description'] ?? '',
      actors: List<String>.from(map['actors']),
      like: map['like']?.toInt() ?? 0,
      bannerUrl: map['bannerUrl'] ?? '',
      screens: List<String>.from(map['screens']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieModel.fromJson(String source) =>
      MovieModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MovieModel(title: $title,title1:$time,name:$name,image:$image,namee:$namee,imagee:$imagee,busNumber:$busNumber, description: $description, actors: $actors, like: $like, bannerUrl: $bannerUrl, screens: $screens)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MovieModel &&
        other.title == title &&
        other.time == time &&
        other.name == name &&
        other.image == image &&
        other.namee == namee &&
        other.imagee == imagee &&
        other.busNumber == busNumber &&
        other.description == description &&
        listEquals(other.actors, actors) &&
        other.like == like &&
        other.bannerUrl == bannerUrl &&
        listEquals(other.screens, screens);
  }

  @override
  int get hashCode {
    return title.hashCode ^
        time.hashCode ^
        busNumber.hashCode ^
        name.hashCode ^
        image.hashCode ^
        namee.hashCode ^
        imagee.hashCode ^
        description.hashCode ^
        actors.hashCode ^
        like.hashCode ^
        bannerUrl.hashCode ^
        screens.hashCode;
  }
}
