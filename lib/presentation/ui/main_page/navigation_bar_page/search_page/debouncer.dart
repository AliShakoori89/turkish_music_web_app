import 'dart:async';
import 'dart:ui';

class Debouncer{
  final int milliseconds;
  Timer? timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action){
    if(timer != null){
      timer!.cancel();
    }

    timer = Timer(Duration(microseconds: milliseconds), action);
  }

  void reset(){
    timer = null;
  }
}