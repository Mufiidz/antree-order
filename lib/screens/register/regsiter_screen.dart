import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../data/auth_repository.dart';
import '../../di/main_module.dart';
import '../../models/user.dart';
import '../../export/export.dart';
import 'bloc/register_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  var _user = User();
  @override
  Widget build(BuildContext context) {
    final size = context.mediaSize;
    return BlocProvider(
      create: (context) => RegisterBloc(getIt<AuthRepository>()),
      child: Scaffold(
        body:
            BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
          if (state is RegisterLoadingState) {
            return const LoadingWidget();
          }

          if (state is RegisterStatusState) {
            if (!state.isSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.snackbar.showSnackBar(SnackBar(
                  content: Text(state.data),
                  backgroundColor: Colors.redAccent,
                ));
              });
            } else {
              _user = User();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.snackbar.showSnackBar(SnackBar(
                    content: Text(state.data), backgroundColor: Colors.green));
              });
            }
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
        TextFieldWidget(
          Const.name,
          initialValue: _user.name,
          label: 'Name',
          hint: 'Your Name',
          textCapitalization: TextCapitalization.words,
        ),
        TextFieldWidget(
          Const.username,
          initialValue: _user.username,
          label: 'Username',
          hint: 'username',
          validators: [
            FormBuilderValidators.minLength(3),
            FormBuilderValidators.maxLength(15)
          ],
        ),
        BlocSelector<RegisterBloc, RegisterState, bool>(
          selector: (state) => state.isHidePassword,
          builder: (context, state) => TextFieldWidget(
            Const.password,
            label: 'Password',
            hint: 'password',
            isObscureText: state,
            suffixIcon: IconButton(
                onPressed: () =>
                    context.read<RegisterBloc>().add(ShowPasswordEvent(!state)),
                icon: Icon(state ? Icons.visibility_off : Icons.visibility)),
            onChanged: (p0) {
              if (p0 != null) {
                context.read<RegisterBloc>().add(PasswordChangeEvent(p0));
              }
            },
            validators: [FormBuilderValidators.minLength(8)],
          ),
        ),
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return TextFieldWidget(
              Const.confirmPassword,
              label: 'Confirm Password',
              hint: 'confirm password',
              isObscureText: state.isHideConfirmPassword,
              suffixIcon: IconButton(
                  onPressed: () => context.read<RegisterBloc>().add(
                      ShowConfirmPasswordEvent(!state.isHideConfirmPassword)),
                  icon: Icon(state.isHideConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility)),
              validators: [
                FormBuilderValidators.equal(state.password,
                    errorText: 'This field value must be same with password.')
              ],
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        ButtonWidget('Register',
            width: size.width * 0.6, onClick: () => _onRegisterClick(context)),
        TextWithTextButtonWidget<RegisterBloc, RegisterState, bool>(
          selector: (state) => state.isHover,
          title: 'Already have an account? ',
          textButton: 'Login.',
          route: LoginRoute(),
          onEnter: (bloc) => bloc.add(const HoverLoginEvent(true)),
          onExit: (bloc) => bloc.add(const HoverLoginEvent(false)),
        ),
      ];

  _onRegisterClick(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final name = _formKey.currentState?.value[Const.name];
      final username = _formKey.currentState?.value[Const.username];
      final password = _formKey.currentState?.value[Const.password];
      _user = User(
        name: name,
        username: username,
        password: password,
      );
      context.read<RegisterBloc>().add(RegisterUserEvent(_user));
    }
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }
}
