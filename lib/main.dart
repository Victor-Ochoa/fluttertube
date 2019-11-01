import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/blocks/favorite_bloc.dart';
import 'package:fluttertube/blocks/videos_bloc.dart';
import 'package:fluttertube/screens/home.dart';

Future main() async => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fluttertube',
      home: Home(),
    ),
    blocs: [Bloc((i) => VideosBloc()),Bloc((i) => FavoriteBloc())],);
  }
}
