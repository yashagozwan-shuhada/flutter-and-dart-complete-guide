import 'dart:async';

import 'package:login_bloc/src/mixins/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailStreamController = BehaviorSubject<String>();
  final _passwordStreamController = BehaviorSubject<String>();

  Stream<String> get streamEmail =>
      _emailStreamController.stream.transform(validateEmail);

  Stream<String> get streamPassword =>
      _passwordStreamController.stream.transform(validatePassword);

  Stream<bool> get streamSubmitValid =>
      Rx.combineLatest2(streamEmail, streamPassword, (e, p) => true);

  void Function(String value) get onChangeEmail =>
      _emailStreamController.sink.add;

  void Function(String value) get onChangePassword =>
      _passwordStreamController.sink.add;

  void submit() {
    final email = _emailStreamController.value;
    final password = _emailStreamController.value;
    print('email: $email, password: $password');
  }

  void dispose() {
    _emailStreamController.close();
    _passwordStreamController.close();
  }
}
