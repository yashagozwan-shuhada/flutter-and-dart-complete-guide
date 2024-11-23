import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/login_bloc.dart';
import 'package:login_bloc/src/blocs/provider.dart';
import 'package:login_bloc/src/widgets/info_widger.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc bloc;

  @override
  void didChangeDependencies() {
    bloc = Provider.of(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildEmailField(),
              const SizedBox(height: 16),
              _buildPasswordField(),
              const SizedBox(height: 24),
              _buildButtonSubmit(),
              const SizedBox(height: 24),
              const InfoWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonSubmit() {
    return StreamBuilder<bool>(
      stream: bloc.streamSubmitValid,
      builder: (context, snapshot) {
        final onPressed = snapshot.hasData ? bloc.submit : null;

        return FilledButton(
          onPressed: onPressed,
          child: const Text(
            'Sign In',
          ),
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return StreamBuilder<String>(
      stream: bloc.streamPassword,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.onChangePassword,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Enter your password',
            labelText: 'Password',
            errorText: snapshot.error as String?,
          ),
        );
      },
    );
  }

  Widget _buildEmailField() {
    return StreamBuilder<String>(
      stream: bloc.streamEmail,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.onChangeEmail,
          decoration: InputDecoration(
            hintText: 'Enter your email',
            labelText: 'Email',
            errorText: snapshot.error as String?,
          ),
        );
      },
    );
  }
}
