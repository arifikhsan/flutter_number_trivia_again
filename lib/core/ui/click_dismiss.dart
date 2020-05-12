import 'package:flutter/material.dart';

class ClickDismiss extends StatelessWidget {
  final Widget child;

  const ClickDismiss({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
