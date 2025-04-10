import 'package:flutter/material.dart';

extension WidgetsExtentions on Widget {
  Widget onTap(Function() onPress) =>
      GestureDetector(onTap: onPress, child: this);
}
