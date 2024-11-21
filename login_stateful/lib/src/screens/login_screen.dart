import 'package:flutter/material.dart';
import 'package:login_stateful/src/mixins/validation_mixin.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final globalKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          key: globalKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              emailField(),
              const SizedBox(height: 16),
              passwordField(),
              const SizedBox(height: 16),
              submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      onSaved: (newValue) {
        if (newValue != null) {
          email = newValue;
        }
      },
      validator: validationEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Email Address',
        hintText: 'you@example.com',
      ),
    );
  }

  Widget passwordField() {
    return TextFormField(
      onSaved: (newValue) {
        if (newValue != null) {
          password = newValue;
        }
      },
      validator: validationPassword,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Enter Password',
        hintText: 'Password',
      ),
    );
  }

  Widget submitButton() {
    return FilledButton(
      onPressed: () {
        if (globalKey.currentState!.validate()) {
          globalKey.currentState?.save();

          print('email: ${email}, password: ${password}');
        }
      },
      child: const Text("Submit"),
    );
  }
}
