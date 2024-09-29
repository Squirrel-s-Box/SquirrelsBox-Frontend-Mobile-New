part of 'sign_up_bloc.dart';

enum SignUpStatus { unknown, authenticated, unauthenticated, loading }

class SignUpState extends Equatable {
  final SignUpStatus status;
  final SessionInfo session;

  const SignUpState({
    this.status = SignUpStatus.unknown,
    this.session = const SessionInfo(code: null, token: null, refreshToken: null),
  });

  SignUpState copyWith({
    SignUpStatus? status,
    SessionInfo? session,
  }) => SignUpState(
      status: status ?? this.status,
      session: session ?? this.session,
  );

  @override
  List<Object> get props => [status, session];
}
