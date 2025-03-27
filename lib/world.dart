import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flame/widgets.dart';

import 'Cat.dart';
import 'Widget.dart';

class MyWorld extends World with HasGameRef{
  late var background;
  late var sr;
  late MyButton btn;
  List<MyCircleButton> changeBtns = [];
  bool isShow = false;

  @override
  Future<void> onLoad() async{
    sr = 'LivingRoom1.jpg';
    background = SpriteComponent(
      sprite: await Sprite.load(sr),
      size: gameRef.size,
      priority: -1,
      // position: Vector2(0,0),
      anchor: Anchor.center,
    );

    add(background);
    add(MyButton(
      position: Vector2(gameRef.size.x/2 - 60, gameRef.size.y/2 - 50),
      onPressed: GetChangeButtons,
    ));
    add(MyCat(
      //고양이 위치
        position: Vector2(0,0)),
    );
  }

  void GetChangeButtons() {
    if (!isShow) {
      //버튼 위치
      final startX = gameRef.size.x/2 - 300;
      final buttonY = gameRef.size.y/2 - 70;
      final buttonSpacing = 120.0;
      //버튼의 움직임
      final moveToEffects = [
        MoveToEffect(Vector2(startX, buttonY), EffectController(duration: 0.5)),
        MoveToEffect(Vector2(startX + buttonSpacing, buttonY),
            EffectController(duration: 0.5)),
        MoveToEffect(Vector2(startX + buttonSpacing * 2, buttonY),
            EffectController(duration: 0.5))
      ];
      for (var i = 0; i < 2; i++) {
        final button = MyCircleButton(
          onPressed: ChangeBackground,
          btn_NUM: i + 1,
          position: Vector2(200, 600),
        );
        changeBtns.add(button);
        add(button);
        button.add(moveToEffects[i]);
      }
      isShow = true;
    } else {
      //버튼 사라질때 위치
      final moveToEffects = [
        MoveToEffect(Vector2(100, 600), EffectController(duration: 0.5)),
        MoveToEffect(Vector2(220, 600), EffectController(duration: 0.5)),
        MoveToEffect(Vector2(340, 600), EffectController(duration: 0.5)),
      ];

      for (var i = 0; i < changeBtns.length; i++) {
        changeBtns[i].add(moveToEffects[i]);
      }
      Future.delayed(const Duration(milliseconds: 500), () {
        for (var button in changeBtns) {
          remove(button);
        }
        changeBtns.clear();
      });
      isShow = false;
    }
  }

  void ChangeBackground(int btn_NUM) async {
    //버튼 눌러서 맵 바꾸기
    switch (btn_NUM){
      case 1:
        sr = 'LivingRoom1.jpg';
        break;
      case 2:
        sr = 'LivingRoom2.jpg';
        break;
      case 3:
        sr = 'LivingRoom3.jpg';
        break;
    }
    background.sprite = await Sprite.load(sr);
  }
}