import 'dart:ui';

import 'package:flame/events.dart';
import 'package:flame/components.dart';

class MyButton extends SpriteComponent with TapCallbacks, DragCallbacks{
  final VoidCallback onPressed;
  var img = 'button1.png';
  MyButton({
    super.position,
    required this.onPressed,
  }){
    size = Vector2.all(50);
    anchor = Anchor.center;
  }

  @override
  Future<void> onLoad() async{
    //이미지
    sprite = await Sprite.load(img);
  }

  @override
  void onTapDown(TapDownEvent event) async{
    img = "button3.png";
    sprite = await Sprite.load(img);
    
    //눌렀을 때 기능 삽입
    onPressed();
  }
  @override
  void onTapUp(TapUpEvent event) async{
    img = "button1.png";
    sprite = await Sprite.load(img);
  }

  @override
  void onDragEnd(DragEndEvent event) async{
    img = "button1.png";
    sprite = await Sprite.load(img);
  }
}

class MyCircleButton extends SpriteComponent with TapCallbacks, DragCallbacks{
  final void Function(int) onPressed;
  var img = 'button1.png';
  final int btn_NUM;
  MyCircleButton({
    super.position,
    required this.onPressed,
    required this.btn_NUM,
  }){
    size = Vector2.all(50);
    anchor = Anchor.center;
  }

  @override
  Future<void> onLoad() async{
    //이미지
    sprite = await Sprite.load(img);
  }

  @override
  void onTapDown(TapDownEvent event) async{
    img = "button3.png";
    sprite = await Sprite.load(img);

    //눌렀을 때 기능 삽입
    onPressed(btn_NUM);
  }
  @override
  void onTapUp(TapUpEvent event) async{
    img = "button1.png";
    sprite = await Sprite.load(img);
  }

  @override
  void onDragEnd(DragEndEvent event) async{
    img = "button1.png";
    sprite = await Sprite.load(img);
  }
}