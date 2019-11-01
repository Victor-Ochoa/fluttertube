import 'dart:async';
import 'dart:convert';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fluttertube/models/video.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

const FAVORITE_KEY = "favorites";

class FavoriteBloc implements BlocBase {
  Map<String, Video> _favorites = {};

  static void _savData(Map<String, Video> data) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(FAVORITE_KEY, json.encode(data));
    });
  }

  final _favController = BehaviorSubject<Map<String, Video>>()
    ..stream.listen(_savData);
  Stream<Map<String, Video>> get outFav => _favController.stream;

  void toggleFavorite(Video video) {
    if (_favorites.containsKey(video.id))
      _favorites.remove(video.id);
    else
      _favorites[video.id] = video;

    _favController.sink.add(_favorites);
  }

  FavoriteBloc() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains(FAVORITE_KEY)) {
        _favorites = json
            .decode(prefs.getString(FAVORITE_KEY))
            .map((k, v) => MapEntry(k, Video.fromJson(v)))
            .cast<String, Video>();

        _favController.sink.add(_favorites);
      }
    });
  }

  @override
  void addListener(listener) {}

  @override
  void dispose() {
    _favController.close();
  }

  @override
  bool get hasListeners => null;

  @override
  void notifyListeners() {}

  @override
  void removeListener(listener) {}
}
