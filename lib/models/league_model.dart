import 'package:football_league_app/utils/api_key.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class League {
  List<Response>? response;

  League({this.response});

  League.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(Response.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Response {
  String? title;
  String? competition;
  String? matchviewUrl;
  String? competitionUrl;
  String? thumbnail;
  String? date;
  List<Videos>? videos;

  Response(
      {this.title,
      this.competition,
      this.matchviewUrl,
      this.competitionUrl,
      this.thumbnail,
      this.date,
      this.videos});

  Response.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    competition = json['competition'];
    matchviewUrl = json['matchviewUrl'];
    competitionUrl = json['competitionUrl'];
    thumbnail = json['thumbnail'];
    date = json['date'];
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(Videos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['competition'] = competition;
    data['matchviewUrl'] = matchviewUrl;
    data['competitionUrl'] = competitionUrl;
    data['thumbnail'] = thumbnail;
    data['date'] = date;
    if (videos != null) {
      data['videos'] = videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static Future<List<Response>> fetchLeagues() async {
    List<Response> results = [];
    final response = await http.get(
        Uri.parse("https://www.scorebat.com/video-api/v3/feed/?token=$apiKey"));
    final jsonData = json.decode(response.body) as Map<String, dynamic>;
    if (jsonData.containsKey('response')) {
      final responseList = jsonData['response'] as List<dynamic>;
      results = responseList
          .map((responseJson) => Response.fromJson(responseJson))
          .toList();
    }
    return results;
  }
}

class Videos {
  String? id;
  String? title;
  String? embed;

  Videos({this.id, this.title, this.embed});

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    embed = json['embed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['embed'] = embed;
    return data;
  }
}
