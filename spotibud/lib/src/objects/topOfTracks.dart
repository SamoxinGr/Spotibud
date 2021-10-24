import 'package:flutter/material.dart';

class topOfTracks {
  String? id;
  String? author;
  var external_urls;
  String? name;
  String? type;

  topOfTracks({
    required this.id,
    required this.author,
    required this.external_urls,
    required this.name,
    required this.type,
  });

  factory topOfTracks.fromJson(Map<String, dynamic> json) {
    return topOfTracks(
      id: json['id'],
      author: json['album']['artists'][0]['name'],
      external_urls: json['external_urls']['spotify'],
      name: json['name'],
      type: json['type'],
    );
  }
}
