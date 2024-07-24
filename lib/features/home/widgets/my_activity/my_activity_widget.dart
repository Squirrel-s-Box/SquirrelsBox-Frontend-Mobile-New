import 'package:flutter/material.dart';

import '../../../../../config/helper/responsive.dart';
import '../../../common_widgets/common_widgets.dart';
import 'tile_activity_register.dart';

part 'my_activity_register.dart';

class MyActivityWidget extends StatelessWidget {
  const MyActivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PrincipalTitle(title: "My Activity"),
        SizedBox(height: responsive.hp(2)),
        const MyActivityRegister(),
      ],
    );
  }
}
