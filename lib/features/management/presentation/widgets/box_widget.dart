import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/router/app_router.dart';
import '../../../../config/theme/colors.dart';
import '../../domain/models/box.dart';
import 'modals/modals.dart';

class BoxWidget extends StatefulWidget {
  final Box box;
  const BoxWidget({
    required this.box,
    super.key,
  });

  @override
  State<BoxWidget> createState() => _BoxWidgetState();
}

class _BoxWidgetState extends State<BoxWidget> {

  @override
  Widget build(BuildContext context) {
    final appRouter = context.read<RouterCubit>();

    return Dismissible(
      key: Key(widget.box.name!),
      confirmDismiss: (direction) async {
        showDialog(context: context,
            builder: (context) => DeleteBoxModal(box: widget.box)
        );
        return false;
      },
      //background: Container(color: Colors.grey),
      child: GestureDetector(
        onTap: () => appRouter.goSections(widget.box.id.toString(), widget.box.name!),
        onLongPress: () {
          _showEditOptions(context);
        },
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Text(widget.box.name ?? ''),
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
            //const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  void _showEditOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 150,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: () {
                  showDialog(context: context,
                      builder: (context) => UpdateBoxModal(box: widget.box)
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                onTap: () {
                  showDialog(context: context,
                      builder: (context) => DeleteBoxModal(box: widget.box)
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}