import 'package:flutter/material.dart';

import '../../../../config/helper/responsive.dart';
import '../widgets/last_boxes_widget.dart';
import '../widgets/my_activity/my_activity_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      //padding: const EdgeInsets.only(left: 10, right: 10),
      //width: double.infinity,
      //height: double.infinity,
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //SizedBox(height: responsive.hp(2)),
          //const TopBarSearcher(),
          //SizedBox(height: responsive.hp(2)),
          const LastBoxesWidget(),
          SizedBox(height: responsive.hp(2)),
          const MyActivityWidget(),
        ]),
      ),
    );
  }
}
