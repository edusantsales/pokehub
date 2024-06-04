import 'dart:convert';

import 'package:flutter/material.dart';

import 'youtube_base_model.dart';

part 'youtube_video_model.map.dart';

@immutable
class YoutubeVideoModel extends YoutubeBaseModel {
  const YoutubeVideoModel({
    super.id,
    super.title,
    super.description,
    super.thumbnailUrl,
    String? channelTitle,
  }) : _channelTitle = channelTitle;

  /// Passar como String o item que retorna do parâmetro items do json
  factory YoutubeVideoModel.fromJson(String source) => fromMap(json.decode(source) as Map<String, dynamic>);

  YoutubeVideoModel copyWith({
    String? id,
    String? title,
    String? description,
    String? thumbnailUrl,
    String? channelTitle,
  }) {
    return YoutubeVideoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      channelTitle: channelTitle ?? this.channelTitle,
    );
  }

  final String? _channelTitle;

  String get channelTitle => _channelTitle ?? '';
}
