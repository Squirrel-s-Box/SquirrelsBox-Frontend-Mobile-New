import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common_widgets/common_widgets.dart';
import '../../domain/models/box.dart';
import '../blocs/box/box_bloc.dart';
import '../widgets/box_widget.dart';

class BoxesPage extends StatefulWidget {
  const BoxesPage({super.key});

  @override
  State<BoxesPage> createState() => _BoxesPageState();
}

class _BoxesPageState extends State<BoxesPage> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoxBloc, BoxState>(
      builder: (context, state) {
        switch (state.status) {
          case BoxStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case BoxStatus.failure:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("An error occurred"),
                  IconButton(
                    onPressed: () {
                      context.read<BoxBloc>().add(const FetchBoxes(userCode: '1'));
                    },
                    icon: const Icon(Icons.refresh_rounded)
                  )
                ],
              ),
            );
          case BoxStatus.success:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PrincipalTitle(title: 'My Boxes'),
                const SizedBox(height: 10),
                Expanded(child: _buildBoxes(state.boxes)),
                const SizedBox(height: 10),
              ],
            );
          case BoxStatus.initial:
            context.read<BoxBloc>().add(const FetchBoxes(userCode: '1'));
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }

  Widget _buildBoxes(List<Box> boxes) => ListView.builder(
    shrinkWrap: true,
    itemCount: boxes.length,
    itemBuilder: (context, index) => BoxWidget(box: boxes[index]),
  );

}