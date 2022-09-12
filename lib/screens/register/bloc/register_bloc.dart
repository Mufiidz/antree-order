import 'package:antree_order/data/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc(this.authRepository) : super(const RegisterState()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(RegisterLoadingState());
      var response = await authRepository.register(event.user);
      if (response.data != null) {
        emit(RegisterStatusState<String>(true, response.data ?? ''));
      } else {
        emit(RegisterStatusState<String>(false, response.message));
      }
    });

    on<PasswordChangeEvent>(
        (event, emit) => emit(state.copyWith(password: event.password)));

    on<ShowPasswordEvent>(
        (event, emit) => emit(state.copyWith(isShownPassword: event.isShown)));

    on<ShowConfirmPasswordEvent>((event, emit) =>
        emit(state.copyWith(isShownConfirmPassword: event.isShown)));

    on<HoverLoginEvent>(
        (event, emit) => emit(state.copyWith(isHover: event.isHover)));

    // test 2 = 99eeb7f1cc164dd
  }
}
