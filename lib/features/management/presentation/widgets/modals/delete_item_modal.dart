import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/item.dart';
import '../../blocs/item/item_bloc.dart';

class DeleteItemModal extends StatelessWidget {
  final Item item;
  const DeleteItemModal({
    required this.item,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final itemBloc = context.read<ItemBloc>();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Delete ${item.name ?? "this section"}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 16.0),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  const TextSpan(text: 'Are you sure to delete '),
                  TextSpan(text: item.name ?? 'this item', style: const TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: ' from section '),
                  TextSpan(text: itemBloc.state.sectionName, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: ' from box '),
                  TextSpan(text: itemBloc.state.boxName, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: '?'),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    itemBloc.add(DeleteItem(
                        itemId: item.id!
                    ));
                    Navigator.of(context).pop();
                  },
                  child: const Text('Delete'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}