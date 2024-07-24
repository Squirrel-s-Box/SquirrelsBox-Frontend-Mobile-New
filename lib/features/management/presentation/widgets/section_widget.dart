import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/router/app_router.dart';
import '../../domain/models/section.dart';
import '../blocs/section/section_bloc.dart';
import 'modals/delete_section_modal.dart';
import 'modals/update_section_modal.dart';

class SectionWidget extends StatelessWidget {
  final Section section;
  final int boxId;
  const SectionWidget({
    required this.section,
    required this.boxId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appRouter = context.read<RouterCubit>();
    String boxName = context.read<SectionBloc>().state.boxName;

    return Column(
      children: [
        GestureDetector(
          onTap: () => appRouter.goItems(section.id.toString(), section.name!),
          child: Stack(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              if (section.color != null && section.color!.isNotEmpty && section.color != 'No Color')
                Positioned(
                  left: 120,
                  top: 0,
                  child: ClipPath(
                    clipper: RibbonClipper(),
                    child: Container(
                      color: Colors.blue,
                      height: 40,
                      width: 20,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Text(section.name ?? '', textAlign: TextAlign.center,)
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
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
                  if (value != null) _showDialog(context, value, boxName);
                });
              },
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
      ],
    );
  }

  void _showDialog(BuildContext context, int option, String boxName) {
    showDialog(
      context: context,
      builder: (context) {
        switch (option) {
          case 1:
            return UpdateSectionModal(section: section, boxName: boxName,);
          case 2:
            return DeleteSectionModal(section: section, boxName: boxName,);
          default:
            return Container();
        }
      },
    );
  }
}

class RibbonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width / 2, size.height * 0.75);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}