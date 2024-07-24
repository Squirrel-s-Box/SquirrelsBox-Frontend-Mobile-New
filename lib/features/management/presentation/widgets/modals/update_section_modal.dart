import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/section.dart';
import '../../blocs/section/section_bloc.dart';

class UpdateSectionModal extends StatefulWidget {
  final Section section;
  final String boxName;
  const UpdateSectionModal({
    required this.section,
    required this.boxName,
    super.key,
  });

  @override
  State<UpdateSectionModal> createState() => _UpdateSectionModalState();
}

class _UpdateSectionModalState extends State<UpdateSectionModal> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController sectionName = TextEditingController();
    sectionName.text = widget.section.name!;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.boxName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Text(widget.section.name ?? 'Update this section',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ]
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Section name'),
              controller: sectionName,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<SectionBloc>().add(UpdateSection(
                        section: widget.section.copyWith(name: sectionName.text)
                    ));
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
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