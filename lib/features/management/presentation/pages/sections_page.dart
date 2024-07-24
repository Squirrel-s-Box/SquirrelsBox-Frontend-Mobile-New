import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common_widgets/atomic/atomic_texts.dart';
import '../../domain/models/section.dart';
import '../blocs/section/section_bloc.dart';
import '../widgets/section_widget.dart';

class SectionsPage extends StatefulWidget {
  final String boxId;
  final String boxName;

  const SectionsPage({
    required this.boxId,
    required this.boxName,
    super.key
  });

  @override
  State<SectionsPage> createState() => _SectionsPageState();
}

class _SectionsPageState extends State<SectionsPage> {
  late final int boxId;
  late final String boxName;

  @override
  void initState() {
    boxId = int.parse(widget.boxId);
    boxName = widget.boxName;
    context.read<SectionBloc>().add(FetchSections(boxId: boxId, boxName: boxName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SectionBloc, SectionState>(
      builder: (context, state) {
        switch (state.status) {
          case SectionStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case SectionStatus.failure:
            return const Center(
              child: Text("An error occurred"),
            );
          case SectionStatus.success:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrincipalTitle(title: boxName),
                const PrincipalTitle(title: 'My Sections'),
                const SizedBox(height: 10),
                Expanded(
                  child: _buildBoxes(state.sections),
                )
              ],
            );
          case SectionStatus.initial:
            context.read<SectionBloc>().add(FetchSections(boxId: boxId, boxName: boxName));
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }

  Widget _buildBoxes(List<Section> sections) =>
      GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1.2,
        children: sections.map((section) => SectionWidget(section: section, boxId: boxId,)).toList(),
      );

}