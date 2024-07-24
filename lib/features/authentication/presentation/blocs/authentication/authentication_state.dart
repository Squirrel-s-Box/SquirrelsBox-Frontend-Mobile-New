part of 'authentication_bloc.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated, loading }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final SessionInfo session;

  const AuthenticationState({
    this.status = AuthenticationStatus.unknown,
    this.session = const SessionInfo(code: null, token: null, refreshToken: null),
  });

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    SessionInfo? session
  }) => AuthenticationState(
      status: status ?? this.status,
      session: session ?? this.session
  );

  @override
  List<Object> get props => [status, session];
}