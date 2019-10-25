import 'dart:convert';

import 'package:fluttertube/models/video.dart';
import 'package:http/http.dart' as http;

const API_KEY = "AIzaSyDM2ZHYZgplPQhuIeToatFAKcxstS57QFc";

class Api {
  String _search;
  String _nextToken;

  Future<List<Video>> search(String search) async {
    var response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10");

    _search = search;
    return decode(response);
  }

  Future<List<Video>> nextPage() async {
    var response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken");

    return decode(response);
  }

  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      _nextToken = decoded["nextPageToken"];
      return decoded["items"].map<Video>((map) => Video.fromJson(map)).toList();
    } else {
      throw Exception("Fail to load videos from api");
    }
  }
}
