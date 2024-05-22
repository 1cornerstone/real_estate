

import 'package:flutter/cupertino.dart';

class RoundContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double padding;
  const RoundContainer({super.key, required this.child, this.color, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: child
    );
  }
}
