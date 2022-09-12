part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final String password;
  final bool isHidePassword;
  final bool isHideConfirmPassword;
  final bool isHover;

  const RegisterState({
    this.password = '',
    this.isHidePassword = true,
    this.isHideConfirmPassword = true,
    this.isHover = false,
  });

  @override
  List<Object?> get props =>
      [password, isHidePassword, isHideConfirmPassword, isHover];

  RegisterState copyWith({
    String? password,
    bool? isShownPassword,
    bool? isShownConfirmPassword,
    bool? isHover,
  }) {
    return RegisterState(
      password: password ?? this.password,
      isHidePassword: isShownPassword ?? isHidePassword,
      isHideConfirmPassword: isShownConfirmPassword ?? isHideConfirmPassword,
      isHover: isHover ?? this.isHover,
    );
  }
}

class RegisterLoadingState extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterStatusState<T> extends RegisterState {
  final bool isSuccess;
  final T data;

  const RegisterStatusState(this.isSuccess, this.data);

  @override
  List<Object?> get props => [data, isSuccess];
}
