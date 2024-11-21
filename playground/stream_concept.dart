import 'dart:async';

class Cake {}

class Order {
  final String type;

  Order({
    required this.type,
  });
}

void main() {
  final controller = StreamController<Order>();

  final baker = StreamTransformer<String, Cake>.fromHandlers(
    handleData: (data, sink) {
      if (data == 'chocolate') {
        sink.add(Cake());
      } else {
        sink.addError('I cant bake that type!');
      }
    },
  );

  controller.sink.add(Order(type: 'chocolate'));
  controller.sink.add(Order(type: 'banana'));

  controller.stream
      .map((order) => order.type)
      .transform(baker)
      .listen((e) => print("heres your cake $e"), onError: print);
}
