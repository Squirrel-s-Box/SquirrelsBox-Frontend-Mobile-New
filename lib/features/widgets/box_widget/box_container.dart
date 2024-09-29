import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';

part 'box_painter.dart';

class BoxContainer extends StatelessWidget {
  const BoxContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 300,
      color: AppColors.coffeeCappuccino,
      child: CustomPaint(
        painter: BoxPainter(),
      ),
    );
  }
}
