import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/box.dart';
import '../../blocs/box/box_bloc.dart';

class DeleteBoxModal extends StatelessWidget {
  final Box box;
  const DeleteBoxModal({
    required this.box,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController boxName = TextEditingController();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Delete ${box.name ?? "this box"}',
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
                  const TextSpan(text: 'You are about to delete the box '),
                  TextSpan(text: box.name ?? 'this box', style: const TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: '. Please type the '),
                  const TextSpan(text: 'box name', style: TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: ' if you are sure to erase it.'),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Box name'),
              controller: boxName,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (boxName.text == (box.name ?? 'this box')) {
                      context.read<BoxBloc>().add(DeleteBox(
                          boxId: box.id!
                      ));
                      Navigator.of(context).pop();
                    }
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