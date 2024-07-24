import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/box/box_bloc.dart';

class AddBoxModal extends StatelessWidget {
  const AddBoxModal({
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
            const Text('Add your box',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Box name'),
              controller: boxName,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                context.read<BoxBloc>().add(AddBox(userCode: '1', name: boxName.text));
                Navigator.of(context).pop();
              },
              child: const Text('Add Box'),
            ),
          ],
        ),
      ),
    );
  }
}