import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/router/app_router.dart';
import '../../../../config/theme/colors.dart';
import '../../../util/constants/numbers.dart';
import '../../../widgets/molecules/buttons.dart';
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

  late final RouterCubit _router;

  bool logging = false;
  bool _isObscure = true;

  @override
  void initState() {
    _router = context.read<RouterCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        switch (state.status) {
          case AuthenticationStatus.unknown:
            setState(() {
              logging = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error?.response.toString() ?? 'An error occurred'),
              backgroundColor: Colors.red,
            ));
            break;
          case AuthenticationStatus.authenticated:
            setState(() {
              logging = false;
            });
            _router.goHome();
            break;
          case AuthenticationStatus.unauthenticated:
            setState(() {
              logging = false;
            });
            break;
          case AuthenticationStatus.loading:
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
            padding: const EdgeInsets.only(top: 10),
            child: TextFormField(
              obscureText: _isObscure,
              controller: passwordController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
            ),
          ),
          /*Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              TextButton(
                onPressed: () => _router.goRouteName('signUp'),
                child: const Text('Sign Up',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),*/
          AppButton(
            logging: logging,
            onPressed: _handleClick,
            text: 'Sign In',
          ),
        ],
      ),
    );
  }

  void _handleClick() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthenticationBloc>().add(
          AuthenticationLoginRequested(user: UserLogin(
              username: emailController.text,
              password: passwordController.text
          ))
      );
    }
  }
}
