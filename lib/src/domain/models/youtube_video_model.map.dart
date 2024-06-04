part of 'youtube_video_model.dart';

YoutubeVideoModel fromMap(Map<String, dynamic> map) {
  return YoutubeVideoModel(
    id: map['id'] as String,
    title: map['snippet']['title'] as String,
    description: map['snippet']['description'] as String,
    thumbnailUrl: map['snippet']['thumbnails']['high']['url'] as String,
    channelTitle: map['snippet']['channelTitle'] as String,
  );
}
