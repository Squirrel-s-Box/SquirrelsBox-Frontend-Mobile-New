part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

final class SignUpRequested extends SignUpEvent {
  final String username;
  final String password;

  const SignUpRequested({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
}
