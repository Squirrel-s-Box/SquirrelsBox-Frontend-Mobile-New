import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/presentation/blocs/authentication/authentication_bloc.dart';
import '../../authentication/presentation/blocs/sign_up/sign_up_bloc.dart';
import '../../widgets/app_widgets.dart';
import '../../management/domain/models/box.dart';
import '../../management/presentation/blocs/box/box_bloc.dart';
import '../../management/presentation/widgets/box_widget.dart';

class LastBoxesWidget extends StatelessWidget {
  const LastBoxesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionCode = context.read<AuthenticationBloc>().state.session.code;
    final sessionCode2 = context.read<SignUpBloc>().state.session.code;
    context.read<BoxBloc>().add(FetchBoxes(userCode: sessionCode ?? sessionCode2!));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const PrincipalTitle(title: "Last boxes used"),
        GridViewBoxes(),
        //_buildBoxes([context.read<BoxBloc>().state.boxes.first]),
      ],
    );
  }

  Widget _buildBoxes(List<Box> boxes) => ListView.builder(
    shrinkWrap: true,
    itemCount: boxes.length,
    itemBuilder: (context, index) => BoxWidget(box: boxes[index]),
  );
}
