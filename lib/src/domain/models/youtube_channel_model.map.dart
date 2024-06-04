part of 'youtube_channel_model.dart';

YoutubeChannelModel fromMap(Map<String, dynamic> map) {
  final List<dynamic> items = map['items'] as List<dynamic>;
  return YoutubeChannelModel(
    id: items.first['id'] as String,
    title: items.first['snippet']['title'] as String,
    description: items.first['snippet']['description'] as String,
    thumbnailUrl: items.first['snippet']['thumbnails']['high']['url'] as String,
    playlistId: items.first['contentDetails']['relatedPlaylists']['uploads'] as String,
  );
}
