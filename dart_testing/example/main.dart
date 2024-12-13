import 'package:dart_testing/src/option.dart';
import 'package:dart_testing/src/prompter.dart';

void main() {
  const options = [
    Option(label: 'I want red', value: 0xfff0),
    Option(label: 'I want blue', value: 0xff00),
  ];

  const prompter = Prompter();

  final colorCode = prompter.askMultiple('Select a color', options);
  final answer = prompter.askBinary('Do you like this lib?');

  print(colorCode.label);
  print(answer);
}
