import 'package:flame/components.dart';
import 'package:flame/events.dart';

class MyCat extends SpriteComponent with TapCallbacks, DragCallbacks, HasGameRef{
  String img = "Player.gif";

  // 고양이의 나이 - 시간이 흐르면 증가, 일정 값을 넘으면 엔딩 이때 happy 값에 따라 다른 엔딩 출력
  int age = 0;
  
  // 시간마다 두 값은 하락하지만 플레이어의 케어로 증가시킬 수 있는 값
  var hungry = 100;
  var sleep = 100;

  // 시간마다 hungry와 sleep 값을 측정하여 지정된 값보다 낮으면 happy 값이 하락 높으면 happy 값 증가
  // happy 값이 너무 낮으면 바로 엔딩 출력하도록 하기
  var happy = 0; 

  bool isMove = false;
  bool isTouch = false;

  MyCat({super.position}):
        super(
        //고양이 크기
        size:Vector2.all(130),
        //이미지 앵커
        anchor: Anchor.center,
      );

  void FallASleep(){
    while(isMove == false && isTouch == false){
      // TODO: 지정된 시간마다 sleep 값이 증가하도록 코드 추가
      sleep += 10;
      if(sleep > 100){
        sleep = 100;
        break;
      }
    }
  }

  @override
  Future<void> onLoad() async{
    //이미지
    sprite = await Sprite.load(img);
  }

  //고양이 만지기
  @override
  void onTapDown(TapDownEvent event) async{
    img = "TapPlayer.gif";
    isTouch = true;
    sprite = await Sprite.load(img);
  }
  @override
  void onTapUp(TapUpEvent event) async{
    img = "Player.gif";
    isTouch = false;
    sprite = await Sprite.load(img);
  }

  
  //드래그로 고양이 옮기기
  @override
  void onDragStart(DragStartEvent event) async{
    img = "MovePlayer.gif";
    isMove = true;
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
    isMove = false;
    isTouch = false;
    sprite = await Sprite.load(img);
  }
  
  
}