import 'package:flame/components.dart';
import 'package:flame/events.dart';

class MyCat extends SpriteComponent with TapCallbacks, DragCallbacks, HasGameRef{
  String img = "Player.gif";

  MyCat({super.position}):
        super(
        //고양이 크기
        size:Vector2.all(130),
        //이미지 앵커
        anchor: Anchor.center,
      );

  @override
  Future<void> onLoad() async{
    //이미지
    sprite = await Sprite.load(img);
  }

  //고양이 만지기
  @override
  void onTapDown(TapDownEvent event) async{
    img = "TapPlayer.gif";
    sprite = await Sprite.load(img);
  }
  @override
  void onTapUp(TapUpEvent event) async{
    img = "Player.gif";
    sprite = await Sprite.load(img);
  }

  
  //드래그로 고양이 옮기기
  @override
  void onDragStart(DragStartEvent event) async{
    img = "MovePlayer.gif";
    sprite = await Sprite.load(img);
  }

  @override
  void onDragUpdate(DragUpdateEvent event){
    position += event.localDelta;

    //화면 안에서만 움직이도록 하기
    if(position.x > gameRef.size.x/2){
      position.x = gameRef.size.x/2;
    }
    if(position.x < -(gameRef.size.x/2)){
      position.x = -(gameRef.size.x/2);
    }
    if(position.y > gameRef.size.y/2){
      position.y = gameRef.size.y/2;
    }
    if(position.y < -(gameRef.size.y/2)){
      position.y = -(gameRef.size.y/2);
    }
  }

  @override
  void onDragEnd(DragEndEvent event) async{
    img = "Player.gif";
    sprite = await Sprite.load(img);
  }
  
  
}