import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix_app/models/webtoon_detail.dart';
import 'package:toonflix_app/models/webtoon_episodes.dart';

import '../models/webtoon.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebToon>> getTodaysToons() async {
    List<WebToon> webtoonInstances = [];
    final url = Uri.parse("$baseUrl/$today");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        final toon = WebToon.fromJson(webtoon);
        webtoonInstances.add(toon);
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebToonDetail> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonWebtoon = jsonDecode(response.body);
      final webtoon = WebToonDetail.fromJson(jsonWebtoon);

      return webtoon;
    }
    throw Error();
  }

  static Future<List<WebToonEpisodes>> getLateEpisodesById(String id) async {
    List<WebToonEpisodes> episodesInstances = [];
    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        final epi = WebToonEpisodes.fromJson(episode);
        episodesInstances.add(epi);
      }
      return episodesInstances;
    }
    throw Error();
  }
}
