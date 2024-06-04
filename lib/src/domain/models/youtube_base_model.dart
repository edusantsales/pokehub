import 'package:flutter/material.dart';

@immutable
abstract class YoutubeBaseModel {
  const YoutubeBaseModel({
    String? id,
    String? title,
    String? description,
    String? thumbnailUrl,
  })  : _id = id,
        _title = title,
        _description = description,
        _thumbnailUrl = thumbnailUrl;

  final String? _id;
  final String? _title;
  final String? _description;
  final String? _thumbnailUrl;

  String get id => _id ?? '';
  String get title => _title ?? '';
  String get description => _description ?? '';
  String get thumbnailUrl => _thumbnailUrl ?? '';
}
