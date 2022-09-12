import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextWithTextButtonWidget<BLOC extends StateStreamable<STATE>, STATE, bool>
    extends StatelessWidget {
  final bool Function(STATE) selector;
  final String title;
  final String textButton;
  final PageRouteInfo<dynamic> route;
  final Function(BLOC) onEnter;
  final Function(BLOC) onExit;
  const TextWithTextButtonWidget(
      {Key? key,
      required this.selector,
      required this.title,
      required this.textButton,
      required this.route,
      required this.onEnter,
      required this.onExit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BLOC, STATE, bool>(
        selector: selector,
        builder: (context, hover) => Center(
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: title,
                      style: const TextStyle(fontSize: 18),
                      children: [
                        TextSpan(
                          text: textButton,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              decoration: hover == true
                                  ? TextDecoration.underline
                                  : null),
                          mouseCursor: SystemMouseCursors.click,
                          onEnter: (event) => onEnter(context.read<BLOC>()),
                          onExit: (event) => onExit(context.read<BLOC>()),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.router.replace(route),
                        )
                      ])),
            ));
  }
}
