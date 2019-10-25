import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fluttertube/api.dart';
import 'package:fluttertube/models/video.dart';

class VideosBloc implements BlocBase {
  Api api;

  List<Video> videos = [];

  VideosBloc() {
    api = Api();

    _searchController.stream.listen(_search);
  }

  final _videosController = StreamController<List<Video>>();
  Stream<List<Video>> get outVideos => _videosController.stream;

  final _searchController = StreamController<String>();
  Sink<String> get inSearch => _searchController.sink;

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => null;

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }

  void _search(String search) async {
    if(search != null) {
    _videosController.sink.add([]);
      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }

    _videosController.sink.add(videos);
  }
}
