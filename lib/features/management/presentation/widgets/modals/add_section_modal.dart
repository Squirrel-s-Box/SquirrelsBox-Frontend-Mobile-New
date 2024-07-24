import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/section/section_bloc.dart';

class AddSectionModal extends StatefulWidget {
  const AddSectionModal({
    super.key,
  });

  @override
  State<AddSectionModal> createState() => _AddSectionModalState();
}

class _AddSectionModalState extends State<AddSectionModal> {
  TextEditingController sectionName = TextEditingController();
  String color = 'No Color';

  @override
  Widget build(BuildContext context) {
    final sectionBloc = context.read<SectionBloc>();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Add your section',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            Text(sectionBloc.state.boxName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Section name'),
              controller: sectionName,
            ),
            const SizedBox(height: 16.0),
            DropdownButton<String>(
              value: color,
              items: <String>['No Color', 'Blue', 'Red', 'Green', 'Yellow']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  color = newValue!;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                sectionBloc.add(
                  AddSection(
                    boxId: sectionBloc.state.boxId,
                    boxName: sectionBloc.state.boxName,
                    name: sectionName.text,
                    color: color
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Add Section'),
            ),
          ],
        ),
      ),
    );
  }
}