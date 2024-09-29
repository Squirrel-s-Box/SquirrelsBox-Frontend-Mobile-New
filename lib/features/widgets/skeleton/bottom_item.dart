import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/router/app_router.dart';
import '../../../../config/theme/colors.dart';
import 'bottom_item_model.dart';

class BottomItem extends StatelessWidget {
  const BottomItem({super.key, required this.item});

  final BottomItemModel item;

  @override
  Widget build(BuildContext context) {
    final appRouter = context.read<RouterCubit>();
    final currentScreen = appRouter.getRouteName();

    return InkWell(
      onTap: () {
        appRouter.goRouteName(item.path);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.translate(
              offset: Offset(item.offsetX, item.offsetY),
              child: Icon(item.icon,
                  color: currentScreen == item.path
                      ? AppColors.darkBlue
                      : AppColors.midOrange
              ),
            ),
            Transform.translate(
              offset: Offset(item.offsetX, item.offsetY),
              child: AutoSizeText(
                item.title,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: currentScreen == item.path
                      ? AppColors.darkBlue
                      : AppColors.midOrange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
