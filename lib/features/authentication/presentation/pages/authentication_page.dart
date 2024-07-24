import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/router/app_router.dart';
import '../../domain/models/user_login.dart';
import '../blocs/authentication/authentication_bloc.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        switch (state.status) {
          case AuthenticationStatus.unknown:
            print('unknown');
            break;
          case AuthenticationStatus.authenticated:
            context.read<RouterCubit>().goHome();
          case AuthenticationStatus.unauthenticated:
            //return loginForm();
          case AuthenticationStatus.loading:
            //return loginForm();
        }
      },
      child: loginForm(),
    );
  }

  Form loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Squirrel\'s Box',
              style: TextStyle(
                color: Color(0xFF7a5635),
                fontWeight: FontWeight.w500,
                fontSize: 36,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              'assets/svg/logo.svg',
              height: 125,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a username';
                }
                return null;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextFormField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 30),
            child: ElevatedButton(
              child: const Text('Sign In'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  //context.read<RouterCubit>().goHome();
                  context.read<AuthenticationBloc>().add(
                    AuthenticationLoginRequested(user: UserLogin(
                      username: emailController.text,
                      password: passwordController.text
                    ))
                  );
                  print('log in');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
