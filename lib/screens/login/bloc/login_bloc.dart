import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/auth_repository.dart';
import '../../../models/user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(const LoginState()) {
    on<LoginUserEvent>((event, emit) async {
      emit(LoginLoadingState());
      var response = await authRepository.login(event.user);
      if (response.data != null) {
        emit(LoginStatusState<User>(true, response.data ?? User()));
      } else {
        emit(LoginStatusState<String>(false, response.message));
      }
    });
    on<HoverRegisterEvent>(
        (event, emit) => emit(state.copyWith(isHover: event.isHover)));
    on<ShowPasswordEvent>(
        (event, emit) => emit(state.copyWith(isHidePassword: event.isShown)));
  }
}
