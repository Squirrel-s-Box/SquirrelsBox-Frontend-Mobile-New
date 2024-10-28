import 'package:flutter/material.dart';
import 'package:squirrels_box_2/config/theme/colors.dart';
import 'package:squirrels_box_2/features/widgets/app_widgets.dart';

class StorageWidget extends StatelessWidget {
  final String name;
  final IconData icon;
  final int boxesUsed;
  final int boxesTotals;

  const StorageWidget(
      {super.key,
      required this.name,
      required this.icon,
      required this.boxesTotals,
      required this.boxesUsed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon),
            const SizedBox(width: 7),
            NormalText(title: name)
          ],
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          margin: const EdgeInsetsDirectional.symmetric(vertical: 7),
          height: 13,
          decoration: BoxDecoration(
            color: AppColors.midOrange,
            borderRadius: BorderRadius.circular(30)
          ),
          child: FractionallySizedBox(
            widthFactor: ((boxesUsed * 100) / boxesTotals)/100,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.strongOrange,
                  borderRadius: BorderRadius.circular(30)
              ),
            ),
          ),
        ),
        NormalText(title: "$boxesUsed of $boxesTotals boxes used")
      ],
    );
  }
}
