import 'package:flutter/material.dart';

import '../../common_widgets/common_widgets.dart';

class LastBoxesWidget extends StatelessWidget {
  const LastBoxesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        PrincipalTitle(title: "Last boxes used"),
        GridViewBoxes(),
      ],
    );
  }
}
