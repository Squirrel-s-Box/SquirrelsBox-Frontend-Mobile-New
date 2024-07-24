import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/box.dart';
import '../../blocs/box/box_bloc.dart';

class UpdateBoxModal extends StatefulWidget {
  final Box box;
  const UpdateBoxModal({
    required this.box,
    super.key,
  });

  @override
  State<UpdateBoxModal> createState() => _UpdateBoxModalState();
}

class _UpdateBoxModalState extends State<UpdateBoxModal> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController boxName = TextEditingController();
    boxName.text = widget.box.name!;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.box.name ?? 'Update this box',
              style: const TextStyle(
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
            Row(
              children: [
                const Text('Favourite? '),
                Switch(
                  value: favorite,
                  onChanged: (newValue) {
                    setState(() {
                      favorite = newValue;
                    });
                  },
                  activeColor: Colors.blue,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey[300],
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<BoxBloc>().add(UpdateBox(
                      box: widget.box.copyWith(name: boxName.text, favorite: favorite)
                    ));
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add Box'),
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