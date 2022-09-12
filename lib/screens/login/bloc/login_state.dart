part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isHidePassword;
  final bool isHover;

  const LoginState({this.isHidePassword = true, this.isHover = false});

  LoginState copyWith({
    bool? isHidePassword,
    bool? isHover,
  }) {
    return LoginState(
      isHidePassword: isHidePassword ?? this.isHidePassword,
      isHover: isHover ?? this.isHover,
    );
  }

  @override
  List<Object?> get props => [isHidePassword, isHover];
}

class LoginLoadingState extends LoginState {}

class LoginStatusState<T> extends LoginState {
  final bool isSuccess;
  final T data;

  const LoginStatusState(this.isSuccess, this.data);

  @override
  List<Object?> get props => [data, isSuccess];
}
