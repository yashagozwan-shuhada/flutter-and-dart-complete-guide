import 'package:dart_testing/src/option.dart';
import 'package:dart_testing/src/terminal.dart';

class Prompter {
  const Prompter();

  static Terminal get _terminal => const Terminal();

  bool askBinary(String prompt) {
    final input = _ask('$prompt (y/n)', []);
    return input.contains('y');
  }

  Option<T> askMultiple<T>(String prompt, List<Option<T>> options) {
    final input = _ask(prompt, options);

    try {
      final index = int.parse(input);
      final option = options[index];
      return option;
    } catch (e) {
      return askMultiple(prompt, options);
    }
  }

  String _ask<T>(String prompt, List<Option<T>> options) {
    _terminal
      ..clearScreen()
      ..printPrompt(prompt)
      ..printOption(options);

    final input = _terminal.collectInput();

    return input;
  }
}
