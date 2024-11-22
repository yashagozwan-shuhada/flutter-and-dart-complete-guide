import 'dart:async';
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final streamController = StreamController<String>.broadcast();

  StreamTransformer<String, String> get validateEmail =>
      StreamTransformer<String, String>.fromHandlers(
        handleData: (data, sink) {
          if (data.isEmpty) {
            sink.addError('Email field cannot be empty');
          } else if (!data.contains('@')) {
            sink.addError('Must enter a valid email');
          } else {
            sink.add(data);
          }
        },
      );

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StreamBuilder(
                stream: streamController.stream.transform(validateEmail),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return const Text('Valid email address');
                  }

                  return const SizedBox.shrink();
                },
              ),
              StreamBuilder<Object>(
                stream: streamController.stream.transform(validateEmail),
                builder: (context, snapshot) {
                  return TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Email Address',
                      labelText: 'Email',
                      errorText: snapshot.error as String?,
                    ),
                    onChanged: (value) {
                      streamController.sink.add(value);
                    },
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
