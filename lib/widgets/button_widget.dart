import 'package:antree_order/export/export_package.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String name;
  final double? width;
  final Function()? onClick;
  const ButtonWidget(this.name, {Key? key, this.onClick, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = context.mediaSize;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
            fixedSize: Size(width ?? size.width * 0.4, 45)),
        onPressed: onClick,
        child: Text(name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),));
  }
}
