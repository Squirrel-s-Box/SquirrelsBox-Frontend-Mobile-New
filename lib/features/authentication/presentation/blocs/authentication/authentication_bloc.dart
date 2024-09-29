import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/models/session_info.dart';
import '../../../domain/models/user_login.dart';
import '../../../services/session_service.dart';
import '../../../util/security.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SessionService service;

  AuthenticationBloc({
    required this.service
  }) : super(const AuthenticationState()) {
    on<AuthenticationLoginRequested>(_onAuthenticationLoginRequested);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
  }

  Future<void> _onAuthenticationLoginRequested(
      AuthenticationLoginRequested event,
      Emitter<AuthenticationState> emit
      ) async {
    emit(state.copyWith(status: AuthenticationStatus.loading));

    await emit.forEach<SessionInfo>(
        service.signIn(event.user).asStream(),
        onData: (info) {
          return state.copyWith(
            status: AuthenticationStatus.authenticated,
            session: info.copyWith(code: Security().aesDecryption(info.code!)),
            //session: info,
          );
        },
        onError: (e, __) {
          final error = e as DioException;
          return state.copyWith(
            status: AuthenticationStatus.unknown,
            error: error,
          );
        }
    );
  }

  Future<void> _onAuthenticationLogoutRequested(
      AuthenticationLogoutRequested event,
      Emitter<AuthenticationState> emit
      ) async {
    emit(state.copyWith(status: AuthenticationStatus.loading));

    //TODO: verify log out endpoint
    /*await emit.forEach<BaseResponse>(
        boxService.addBox(
            Box(
                name: event.name
            ), '1'
        ).asStream(),
        onData: (boxes) => state.copyWith(
          status: BoxStatus.success,
        ),
        onError: (_, __) => state.copyWith(
            status: BoxStatus.failure
        )
    );*/
  }
}
