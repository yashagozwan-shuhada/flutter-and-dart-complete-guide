import 'dart:async';

import 'package:flutter/material.dart';

class SimpleGameScreen extends StatefulWidget {
  const SimpleGameScreen({super.key});

  @override
  State<SimpleGameScreen> createState() => _SimpleGameScreenState();
}

class _SimpleGameScreenState extends State<SimpleGameScreen> {
  late StreamController<String?> _streamController;
  late StreamController<bool> _streamController2;

  late final TextEditingController _inputController;

  Stream<String> get stream => _streamController.stream.take(4).transform(
        StreamTransformer<String, String>.fromHandlers(
          handleData: (data, sink) {
            if (data == 'banana') {
              sink.add('You got the item $data');
            } else {
              sink.addError('Word wrong');
            }
          },
          handleDone: (sink) {
            _streamController2.sink.add(true);
            sink.addError('You Lose');
          },
        ),
      );

  void Function(String?) get onChange => _streamController.sink.add;

  void _reloadStream() {
    _streamController.close();
    _streamController2.close();

    _streamController = StreamController<String?>.broadcast();
    _streamController2 = StreamController<bool>.broadcast();
  }

  @override
  void initState() {
    _streamController = StreamController<String>();
    _streamController2 = StreamController<bool>();

    _inputController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    _streamController2.close();
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StreamBuilder(
                stream: stream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  if (snapshot.hasData) {
                    return Text('${snapshot.data}');
                  }

                  return const SizedBox.shrink();
                },
              ),
              TextField(
                controller: _inputController,
                decoration: const InputDecoration(
                  hintText: 'text...',
                  labelText: 'input',
                ),
              ),
              const SizedBox(height: 16),
              StreamBuilder(
                initialData: false,
                stream: _streamController2.stream,
                builder: (context, snapshot) {
                  if (snapshot.data!) {
                    return ElevatedButton(
                      onPressed: () {
                        _streamController2.sink.add(false);
                        _reloadStream();
                      },
                      child: const Text('Reload'),
                    );
                  }

                  return ElevatedButton(
                    onPressed: () {
                      onChange(_inputController.text);
                    },
                    child: const Text('Submit'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
