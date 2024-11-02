import 'package:flutter/material.dart';

import '../../../../config/helper/responsive.dart';
import '../../management/domain/models/box.dart';
import '../../management/presentation/widgets/box_widget.dart';
import '../../util/preferences/app_shared_preferences.dart';
import '../../widgets/atomic/atomic_texts.dart';
import '../widgets/my_activity/my_activity_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Box> boxList = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> getBoxesUsed() async {
    boxList = await getLastBoxesUsed();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const PrincipalTitle(title: "Last boxes used"),
          showBoxes(),
          SizedBox(height: responsive.hp(2)),
          const MyActivityWidget(),
        ]),
      ),
    );
  }

  showBoxes() {
    return FutureBuilder(
      future: getBoxesUsed(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());

        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');

        } else {
          if (boxList.isNotEmpty) {
            return _buildBoxes(boxList);
          } else {
            return const Text('No boxes used');
          }
        }
      },
    );
  }

  Widget _buildBoxes(List<Box> boxes) => ListView.builder(
    shrinkWrap: true,
    itemCount: boxes.length,
    itemBuilder: (context, index) => Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: BoxWidget(box: boxes[index]),
    ),
  );
}
