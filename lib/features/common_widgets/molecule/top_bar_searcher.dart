import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../atomic/principal_input_search.dart';

class TopBarSearcher extends StatelessWidget {
  const TopBarSearcher({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          const Expanded(child: PrincipalInputSearch()),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
            color: AppColors.darkBlue,
          ),
        ],
      ),
    );
  }
}
