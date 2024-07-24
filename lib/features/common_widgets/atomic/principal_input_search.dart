import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';

class PrincipalInputSearch extends StatelessWidget {
  const PrincipalInputSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.darkBlue)),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt),
            color: AppColors.darkBlue,
          ),
          Container(
              color: AppColors.placeholderColor,
              width: 1,
              height: double.infinity,
              margin: const EdgeInsets.only(right: 10, top: 5, bottom: 5)),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
