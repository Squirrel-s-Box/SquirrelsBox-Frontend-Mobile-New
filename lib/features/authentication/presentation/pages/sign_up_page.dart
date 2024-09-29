import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/router/app_router.dart';
import '../../../../config/theme/colors.dart';
import '../../../util/constants/numbers.dart';
import '../../../util/logger/app_logger.dart';
import '../../../widgets/molecules/buttons.dart';
import '../blocs/sign_up/sign_up_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool logging = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        switch (state.status) {
          case SignUpStatus.unknown:
            setState(() {
              logging = false;
            });
            AppLogger.info('unknown');
            break;
          case SignUpStatus.authenticated:
            setState(() {
              logging = false;
            });
            context.read<RouterCubit>().goHome();
            break;
          case SignUpStatus.unauthenticated:
            setState(() {
              logging = false;
            });
            break;
          case SignUpStatus.loading:
            setState(() {
              logging = true;
            });
            break;
        }
      },
      child: Scaffold(
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: loginForm()
        ),
      ),
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
                color: AppColors.blackBrown,
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
            padding: const EdgeInsets.only(top: 10),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
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
            padding: const EdgeInsets.only(top: 20),
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
            padding: const EdgeInsets.only(top: 10),
            child: TextFormField(
              obscureText: true,
              controller: confirmPasswordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Confirm Password',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                if (value != passwordController.text) {
                  return 'Both password must be the same';
                }
                return null;
              },
            ),
          ),
          AppButton(
            logging: logging,
            onPressed: _handleClick,
            text: 'Sign Up',
          ),
        ],
      ),
    );
  }

  void _handleClick() {
    if (_formKey.currentState!.validate()) {
      context.read<SignUpBloc>().add(
          SignUpRequested(
            username: emailController.text,
            password: passwordController.text
          )
      );
    }
  }
}
