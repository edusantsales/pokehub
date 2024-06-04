import 'dart:convert';

import 'package:flutter/material.dart';

import 'youtube_base_model.dart';
import 'youtube_video_model.dart';

part 'youtube_channel_model.map.dart';

@immutable
class YoutubeChannelModel extends YoutubeBaseModel {
  const YoutubeChannelModel({
    super.id,
    super.title,
    super.description,
    super.thumbnailUrl,
    String? playlistId,
    List<YoutubeVideoModel>? videos,
  })  : _playlistId = playlistId,
        _videos = videos;

  /// Passar como String o response.body
  factory YoutubeChannelModel.fromJson(String source) => fromMap(json.decode(source) as Map<String, dynamic>);

  YoutubeChannelModel copyWith({
    String? id,
    String? title,
    String? description,
    String? thumbnailUrl,
    String? playlistId,
    List<YoutubeVideoModel>? videos,
  }) {
    return YoutubeChannelModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      playlistId: playlistId ?? this.playlistId,
      videos: videos ?? this.videos,
    );
  }

  final String? _playlistId;
  final List<YoutubeVideoModel>? _videos;

  String get playlistId => _playlistId ?? '';
  List<YoutubeVideoModel> get videos => _videos ?? <YoutubeVideoModel>[];
}
