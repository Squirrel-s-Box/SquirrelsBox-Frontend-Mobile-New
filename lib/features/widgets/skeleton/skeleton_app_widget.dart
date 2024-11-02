import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/router/app_router.dart';
import '../../../../config/theme/colors.dart';
import '../../authentication/presentation/blocs/authentication/authentication_bloc.dart';
import '../../authentication/presentation/blocs/sign_up/sign_up_bloc.dart';
import '../../management/presentation/widgets/modals/modals.dart';
import 'bottom_item.dart';
import 'bottom_item_model.dart';

part 'bottom_bar.dart';
part 'floating_action_bottom_widget.dart';

class SkeletonAppWidget extends StatelessWidget {
  const SkeletonAppWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final appRouter = context.read<RouterCubit>();

    return Scaffold(
      appBar: appRouter.getRouteName() == 'item' || appRouter.getRouteName() == 'camera'
          ? null
          : AppBar(
            title: const Text("Squirrel's Box"),
            actions: actionsWidgets(appRouter),
          ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 35),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        height: double.infinity,
        child: child,
      ),
      floatingActionButtonLocation: appRouter.getRouteName() == 'camera'
          ? null : FloatingActionButtonLocation.centerDocked,
      floatingActionButton: appRouter.getRouteName() == 'camera'
          ? null : FloatingActionBottomWidget(routeName: appRouter.getRouteName()),
      bottomNavigationBar: appRouter.getRouteName() == 'camera'
          ? null : BottomBar(),
    );
  }

  List<Widget> actionsWidgets(RouterCubit appRouter) {
    Map<String, List<Map<IconData, Function>>> screenActions = {
      'home': [
        {Icons.extension_rounded: () => appRouter.goComingSoon()},
        {Icons.camera_alt_rounded: () => appRouter.goComingSoon()},
        {Icons.search: () => appRouter.goComingSoon()},
        {Icons.notifications: () => appRouter.goComingSoon()},
      ],
      'boxes': [
        {Icons.star_border_rounded: () => appRouter.goComingSoon()},
        {Icons.search: () => appRouter.goComingSoon()},
        {Icons.filter_alt_rounded: () => appRouter.goComingSoon()}, //TODO: add filter method
      ],
      'sections': [
        {Icons.star_border_rounded: () => appRouter.goComingSoon()},
        {Icons.search: () => appRouter.goComingSoon()},
        {Icons.filter_alt_rounded: () => appRouter.goComingSoon()}, //TODO: add filter method
      ],
      'items': [
        {Icons.camera_alt_rounded: () => appRouter.goComingSoon()},
        {Icons.search: () => appRouter.goComingSoon()},
        {Icons.filter_alt_rounded: () => appRouter.goComingSoon()}, //TODO: add filter method
      ],
      'profile':[
        {Icons.notifications : ()=> print("xd")},
        {Icons.settings : ()=> appRouter.goSettings()},
      ]
    };

    return screenActions[appRouter.getRouteName()]?.map((actionMap) {
      IconData icon = actionMap.keys.first;
      Function? action = actionMap[icon];
      return IconButton(
        icon: Icon(icon, color: Colors.black),
        onPressed: () => action!(),
      );
    }).toList() ?? [];
  }
}