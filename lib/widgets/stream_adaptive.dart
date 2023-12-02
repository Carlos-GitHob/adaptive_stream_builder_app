import 'dart:async';
import 'dart:math';

class AdaptiveStream{
  final _controller = StreamController<String>();
  final _random = Random();

  Stream<String> get messageStream => _controller.stream;

  void startMessages(){
    List<String> messages = [
      "Hola, mi nombre es Carlos",
      "Este es mi trabajo!",
      "Este es un stream en Flutter con Stream",
      "Streams son geniales para brindar datos en tiempo real",
      "Estas lineas de textos son aleatorias",
    ];

    Timer.periodic(const Duration(seconds:3), (timer) { 
      String randomMessage = messages[_random.nextInt(messages.length)];
      _controller.sink.add(randomMessage);
    });
  }
    void dispose(){
      _controller.close();
    }
  
}