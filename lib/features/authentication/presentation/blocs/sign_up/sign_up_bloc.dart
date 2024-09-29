import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:squirrels_box_2/features/authentication/domain/models/user_login.dart';

import '../../../domain/models/session_info.dart';
import '../../../services/session_service.dart';
import '../../../util/security.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SessionService service;

  SignUpBloc({
    required this.service
  }) : super(const SignUpState()) {
    on<SignUpRequested>(_onSignUpRequested);
  }

  Future<void> _onSignUpRequested(
      SignUpRequested event,
      Emitter<SignUpState> emit
      ) async {
    emit(state.copyWith(status: SignUpStatus.loading));

    await emit.forEach<SessionInfo>(
        service.signUp(UserLogin(
          username: event.username,
          password: event.password,
        )).asStream(),
        onData: (info) {
          return state.copyWith(
            status: SignUpStatus.authenticated,
            session: info.copyWith(code: Security().aesDecryption(info.code!)),
            //session: info,
          );
        },
        onError: (e, __) {
          return state.copyWith(status: SignUpStatus.unknown);
        }
    );
  }

}
