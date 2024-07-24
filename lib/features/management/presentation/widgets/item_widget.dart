import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/router/app_router.dart';
import '../../domain/models/item.dart';
import '../blocs/item/item_bloc.dart';
import 'modals/modals.dart';

class ItemWidget extends StatefulWidget {
  final Item item;
  const ItemWidget({
    required this.item,
    super.key,
  });

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  late final RouterCubit appRouter;
  late final ItemBloc itemBloc;

  @override
  void initState() {
    appRouter = context.read<RouterCubit>();
    itemBloc = context.read<ItemBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.item.name!),
      onDismissed: (direction) {
        setState(() {
          itemBloc.add(DeleteItem(itemId: widget.item.id!));
        });
      },
      background: Container(color: Colors.redAccent),
      child: Column(
        children: [
          Card(
            elevation: 0,
            child: ListTile(
              leading: const FlutterLogo(size: 56.0),
              title: Text(widget.item.name ?? ''),
              subtitle: Text(widget.item.description ?? ''),
              trailing: Column(
                children: [
                  Text(widget.item.amount ?? '', style: const TextStyle(fontSize: 20),),
                  Text(widget.item.amount ?? '', style: const TextStyle(fontSize: 12),),
                ],
              ),
              onLongPress: _showMenu,
              onTap: () => appRouter.goItemSpecifications(widget.item.id.toString(), widget.item.name!),
            ),
          ),
          const Divider()
        ],
      ),
    );
  }

  void _showMenu() {
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
      if (value != null) _showDialog(value);
    });
  }

  void _showDialog(int option) {
    showDialog(
      context: context,
      builder: (context) {
        switch (option) {
          case 1:
            return UpdateItemModal(item: widget.item);
          case 2:
            return DeleteItemModal(item: widget.item);
          default:
            return Container();
        }
      },
    );
  }
}