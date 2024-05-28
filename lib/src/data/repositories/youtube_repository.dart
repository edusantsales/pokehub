import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import '../../domain/interfaces/adapters/http_client_interface.dart';
import '../../domain/models/exception_model.dart';
import '../../domain/models/response_model.dart';
import '../../domain/models/youtube_channel_model.dart';
import '../../domain/models/youtube_video_model.dart';
import '../adapters/youtube_api_adapter.dart';

class YoutubeRepository {
  YoutubeRepository(this._client);

  final HttpClientInterface _client;

  String _nextPageToken = '';

  void _loggerGeneric(GenericException ge) {
    final GenericTypeException type = ge.typeException as GenericTypeException;
    log('==================== ${type.headerMessage} ====================');
    log(ge.error.toString());
    log(type.bodyMessage);
    log('==============================================================');
  }

  void _loggerServer(ServerException se) {
    final ServerTypeException type = se.typeException as ServerTypeException;
    log('==================== ${type.statusMessage} ====================');
    log(se.error.toString());
    log(se.statusMessage.toString());
    log(se.statusCode.toString());
    log(type.statusCode.toString());
    log('==============================================================');
  }

  Future<YoutubeChannelModel> getChannel({required String channelId}) async {
    try {
      final ResponseModel response = await _client.get(
        '/channels',
        queryParameters: <String, dynamic>{
          'part': 'snippet,contentDetails',
          'id': channelId,
          'key': youtubeApiKey,
        },
      );
      final YoutubeChannelModel channel = YoutubeChannelModel.fromJson(response.body as String);
      final List<YoutubeVideoModel> videos = await getVideosFromPlaylist(playlistId: channel.playlistId);

      return channel.copyWith(videos: videos);
    } on HttpResponse catch (e) {
      final ServerException se = ServerException(
        e,
        ServerTypeException.verify(e.statusCode),
        statusCode: e.statusCode,
        statusMessage: e.reasonPhrase,
      );
      final GenericException ge = GenericException(e, GenericTypeException.getYoutubeChannel);
      _loggerServer(se);
      _loggerGeneric(ge);
      // return FailurePokemonState(se);
      throw se;
    } catch (e) {
      final GenericException ge = GenericException(e, GenericTypeException.getYoutubeChannel);
      _loggerGeneric(ge);
      // return FailurePokemonState(ge);
      throw ge;
    }
  }

  Future<List<YoutubeVideoModel>> getVideosFromPlaylist({required String playlistId, String maxResults = '20'}) async {
    try {
      final ResponseModel response = await _client.get(
        '/playlistItems',
        queryParameters: <String, dynamic>{
          'part': 'snippet',
          'playlistId': playlistId,
          'maxResults': maxResults,
          'pageToken': _nextPageToken,
          'key': youtubeApiKey,
        },
      );
      final dynamic data = jsonDecode(response.body as String);

      _nextPageToken = (data['nextPageToken'] ?? '') as String;

      final List<dynamic> items = data['items'] as List<dynamic>;
      final List<YoutubeVideoModel> videos = <YoutubeVideoModel>[];

      for (final dynamic item in items) {
        videos.add(YoutubeVideoModel.fromJson(jsonEncode(item)));
      }

      return videos;
    } on HttpResponse catch (e) {
      final ServerException se = ServerException(
        e,
        ServerTypeException.verify(e.statusCode),
        statusCode: e.statusCode,
        statusMessage: e.reasonPhrase,
      );
      final GenericException ge = GenericException(e, GenericTypeException.getYoutubePlaylist);
      _loggerServer(se);
      _loggerGeneric(ge);
      // return FailurePokemonState(se);
      throw se;
    } catch (e) {
      final GenericException ge = GenericException(e, GenericTypeException.getYoutubePlaylist);
      _loggerGeneric(ge);
      // return FailurePokemonState(ge);
      throw ge;
    }
  }
}
