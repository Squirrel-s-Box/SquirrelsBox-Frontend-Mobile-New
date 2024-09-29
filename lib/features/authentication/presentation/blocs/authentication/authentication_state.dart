part of 'authentication_bloc.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated, loading }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final SessionInfo session;
  final DioException? error;

  const AuthenticationState({
    this.status = AuthenticationStatus.unknown,
    this.session = const SessionInfo(code: null, token: null, refreshToken: null),
    this.error,
  });

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    SessionInfo? session,
    DioException? error,
  }) => AuthenticationState(
      status: status ?? this.status,
      session: session ?? this.session,
      error: error ?? this.error,
  );

  @override
  List<Object> get props => [status, session];
}