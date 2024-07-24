import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/router/app_router.dart';
import '../../../../config/theme/colors.dart';
import '../../domain/models/box.dart';
import 'modals/modals.dart';

class BoxWidget extends StatelessWidget {
  final Box box;
  const BoxWidget({
    required this.box,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appRouter = context.read<RouterCubit>();

    return GestureDetector(
      onTap: () => appRouter.goSections(box.id.toString(), box.name!),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                color: AppColors.cartoon,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(box.name ?? ''),
                  IconButton(
                    onPressed: () {
                      final size = MediaQuery.of(context).size;
                      const menuWidth = 150.0;
                      const menuHeight = 100.0;

                      final center = Offset(size.width / 2, size.height / 3);

                      final position = RelativeRect.fromSize(
                        Rect.fromCenter(center: center, width: menuWidth, height: menuHeight),
                        size,
                      );

                      showMenu(
                        context: context,
                        position: position,
                        items: <PopupMenuItem>[
                          const PopupMenuItem<int>(value: 1,
                            child: Row(
                              children: [
                                Icon(Icons.edit),
                                SizedBox(width: 8),
                                Text('Edit'),
                              ],
                            ),
                          ),
                          const PopupMenuItem<int>(value: 2,
                            child: Row(
                              children: [
                                Icon(Icons.delete),
                                SizedBox(width: 8),
                                Text('Delete'),
                              ],
                            ),
                          ),
                        ],
                      ).then((value) {
                        if (value != null) _showDialog(context, value);
                      });
                    },
                    icon: const Icon(Icons.more_horiz),
                  ),
                ],
              )
          ),
          Container(color: AppColors.midOrange, height: 10,),
          Container(color: AppColors.cartoon, height: 3,),
          Container(color: AppColors.midOrange, height: 10,),
          Container(
            height: 25,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: const BoxDecoration(
              color: AppColors.cartoon,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4)),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context, int option) {
    showDialog(
      context: context,
      builder: (context) {
        switch (option) {
          case 1:
            return UpdateBoxModal(box: box);
          case 2:
            return DeleteBoxModal(box: box);
          default:
            return Container();
        }
      },
    );
  }

}