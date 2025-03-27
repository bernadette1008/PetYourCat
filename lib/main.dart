import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:fproject/world.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: FlameGame(
      world:MyWorld(),
    ),
    );
  }
}
