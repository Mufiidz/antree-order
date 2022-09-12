import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../data/auth_repository.dart';
import '../../di/main_module.dart';
import '../../export/export.dart';
import '../../models/user.dart';
import 'bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  final NavigationResolver? resolver;
  const LoginScreen({Key? key, this.resolver}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  var _user = User();
  @override
  Widget build(BuildContext context) {
    final size = context.mediaSize;
    return BlocProvider(
      create: (context) => LoginBloc(getIt<AuthRepository>()),
      child: Scaffold(
        body: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          if (state is LoginLoadingState) {
            return const LoadingWidget();
          }

          if (state is LoginStatusState<String>) {
            if (!state.isSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.snackbar.showSnackBar(SnackBar(
                  content: Text(state.data),
                  backgroundColor: Colors.redAccent,
                ));
              });
            }
          }

          if (state is LoginStatusState<User>) {
            _user = User();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.snackbar.showSnackBar(SnackBar(
                  content: Text(state.data.username),
                  backgroundColor: Colors.green));
              final resolver = widget.resolver;
              if (resolver != null && resolver.isResolved) {
                resolver.next();
              } else {
                context.router.replaceAll([const HomeRoute()]);
              }
            });
          }

          return Row(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    alignment: Alignment.center,
                    child: FormBuilder(
                      key: _formKey,
                      child: ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(32),
                          itemBuilder: (context, index) =>
                              _getWidget(size, context)[index],
                          separatorBuilder: ((context, index) => const SizedBox(
                                height: 20,
                              )),
                          itemCount: _getWidget(size, context).length),
                    ),
                  )),
              const Expanded(child: SizedBox()),
            ],
          );
        }),
      ),
    );
  }

  List<Widget> _getWidget(Size size, BuildContext context) => [
        Center(
            child: Text('Login',
                style: context.textTheme.headline2
                    ?.merge(const TextStyle(color: Colors.black)))),
        TextFieldWidget(
          'username',
          initialValue: _user.username,
          label: 'Username',
          hint: 'username',
          textCapitalization: TextCapitalization.words,
        ),
        BlocSelector<LoginBloc, LoginState, bool>(
          selector: (state) => state.isHidePassword,
          builder: (context, state) {
            return TextFieldWidget(
              'password',
              label: 'Password',
              hint: 'password',
              isObscureText: state,
              suffixIcon: IconButton(
                  onPressed: () =>
                      context.read<LoginBloc>().add(ShowPasswordEvent(!state)),
                  icon: Icon(state ? Icons.visibility_off : Icons.visibility)),
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        ButtonWidget(
          "Login",
          width: size.width * 0.6,
          onClick: () => _onLoginClick(context),
        ),
        TextWithTextButtonWidget<LoginBloc, LoginState, bool>(
            selector: (state) => state.isHover,
            title: 'No Account? ',
            textButton: 'Create one.',
            route: const RegisterRoute(),
            onEnter: (bloc) => bloc.add(const HoverRegisterEvent(true)),
            onExit: (bloc) => bloc.add(const HoverRegisterEvent(false))),
      ];

  _onLoginClick(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final username = _formKey.currentState?.value[Const.username];
      final password = _formKey.currentState?.value[Const.password];
      _user = User(
        username: username,
        password: password,
      );
      context.read<LoginBloc>().add(LoginUserEvent(_user));
    }
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }
}
