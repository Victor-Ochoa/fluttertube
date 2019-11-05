import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:fluttertube/api.dart';
import 'package:fluttertube/blocks/favorite_bloc.dart';
import 'package:fluttertube/models/video.dart';

class Favorites extends StatelessWidget {
  final bloc = BlocProvider.getBloc<FavoriteBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder<Map<String, Video>>(
        stream: bloc.outFav,
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data.values
                .map((video) => InkWell(
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 50,
                            width: 100,
                            child: Image.network(video.thumb),
                          ), 
                          Expanded(child: Text(video.title, style: TextStyle(color: Colors.white70),maxLines: 2,),)
                        ],
                      ),
                      onTap: (){
                        FlutterYoutube.playYoutubeVideoById(apiKey: API_KEY,videoId: video.id, appBarColor: Colors.black);
                      },
                      onLongPress: (){
                        bloc.toggleFavorite(video);
                      },
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
