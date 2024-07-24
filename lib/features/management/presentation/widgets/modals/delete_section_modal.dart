import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/section.dart';
import '../../blocs/section/section_bloc.dart';

class DeleteSectionModal extends StatelessWidget {
  final Section section;
  final String boxName;
  const DeleteSectionModal({
    required this.section,
    required this.boxName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Delete ${section.name ?? "this section"}',
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
                  TextSpan(text: section.name ?? 'this section', style: const TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: ' from box '),
                  TextSpan(text: boxName, style: const TextStyle(fontWeight: FontWeight.bold)),
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
                    context.read<SectionBloc>().add(DeleteSection(
                        sectionId: section.id!
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