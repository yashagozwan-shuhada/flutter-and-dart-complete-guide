import 'dart:io';

import 'package:converter/converter.dart';
import 'package:dart_testing/dart_testing.dart';

void main(List<String> arguments) {
  final prompter = Prompter();

  final choice = prompter.askBinary("Are you here to covert an image?");
  if (!choice) {
    exit(0);
  }

  final format = prompter.askMultiple('Select format:', buildFormatOptions());
  final selectedFile =
      prompter.askMultiple('Select an image to convert:', buildFileOptions());

  final newPath = Converter().convertImage(selectedFile.value, format.value);

  final shouldOpen = prompter.askBinary('Open the image?');

  if (shouldOpen && newPath != null) {
    Process.runSync(
      'start',
      [newPath],
      runInShell: true,
    );
  }
}

List<Option<String>> buildFormatOptions() {
  return [
    Option(label: 'Convert to JPG', value: 'jpg'),
    Option(label: 'Convert to PNG', value: 'png'),
  ];
}

List<Option<FileSystemEntity>> buildFileOptions() {
  return Directory.current
      .listSync()
      .where((e) =>
          FileSystemEntity.isFileSync(e.path) &&
          e.path.contains(RegExp(r'\.(png|jpg|jpeg)')))
      .map((e) {
    final name = e.path.split(Platform.pathSeparator).last;
    return Option(label: name, value: e);
  }).toList();
}
