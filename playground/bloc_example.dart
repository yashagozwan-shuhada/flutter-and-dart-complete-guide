import 'dart:async';

void main() {
  final bloc = Bloc();

  // bloc.emailController.stream.listen((event) {
  //   print(event);
  // });

  /// bloc.emailController.sink.add("maria@empress.com");

  bloc.email.listen((event) {
    print(event);
  });

  bloc.changeEmail("aira@empress.com");
}

class Bloc {
  final _emailController = StreamController<String>();

  // add data to stream
  void Function(String value) get changeEmail => _emailController.sink.add;

  // retrieve data from stream
  Stream<String> get email => _emailController.stream;
}
