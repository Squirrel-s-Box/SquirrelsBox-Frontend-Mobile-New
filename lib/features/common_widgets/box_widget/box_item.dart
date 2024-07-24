import 'package:flutter/material.dart';

import '../atomic/atomic_texts.dart';
import 'box_container.dart';

part 'box_texts.dart';
part 'box_options_icon.dart';

class BoxItem extends StatelessWidget {
  const BoxItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 120,
        width: 300,
        child: Stack(
          children: [
            BoxContainer(),
            BoxTexts(),
            BoxOptionsIcon(),
          ],
        ),
      ),
    );
  }
}
