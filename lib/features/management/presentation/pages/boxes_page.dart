import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squirrels_box_2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart';

import '../../../authentication/presentation/blocs/sign_up/sign_up_bloc.dart';
import '../../../widgets/app_widgets.dart';
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
    final sessionCode = context.read<AuthenticationBloc>().state.session.code;
    final sessionCode2 = context.read<SignUpBloc>().state.session.code;

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
                      context.read<BoxBloc>().add(FetchBoxes(userCode: sessionCode ?? sessionCode2!));
                    },
                    icon: const Icon(Icons.refresh_rounded)
                  )
                ],
              ),
            );
          case BoxStatus.success:
            return state.boxes.isNotEmpty? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PrincipalTitle(title: 'My Boxes'),
                const SizedBox(height: 10),
                Expanded(child: _buildBoxes(state.boxes)),
                const SizedBox(height: 10),
              ],
            ) : const Center(child: Text('Do not exist any box'),);
          case BoxStatus.initial:
            context.read<BoxBloc>().add(FetchBoxes(userCode: sessionCode ?? sessionCode2!));
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
    itemBuilder: (context, index) => Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: BoxWidget(box: boxes[index]),
    ),
  );

}