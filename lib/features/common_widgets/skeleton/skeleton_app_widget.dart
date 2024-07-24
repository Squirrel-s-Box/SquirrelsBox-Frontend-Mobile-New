import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/router/app_router.dart';
import '../../../../config/theme/colors.dart';
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
      appBar: appRouter.getRouteName() == 'item' || appRouter.getRouteName() == 'authentication'
          ? null
          : AppBar(
            title: const Text("Squirrel's Box"),
            actions: actionsWidgets(appRouter.getRouteName()),
          ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 35),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        width: double.infinity,
        height: double.infinity,
        child: child,
      ),
      floatingActionButtonLocation: appRouter.getRouteName() == 'authentication'? null : FloatingActionButtonLocation.centerDocked,
      floatingActionButton: appRouter.getRouteName() == 'authentication'? null : FloatingActionBottomWidget(routeName: appRouter.getRouteName()),
      bottomNavigationBar: appRouter.getRouteName() == 'authentication'? null : BottomBar(),
    );
  }

  List<Widget> actionsWidgets(String currentScreen) {
    Map<String, List<Map<IconData, Function>>> screenActions = {
      'home': [
        {Icons.extension_rounded: () => print('Extension action')},
        {Icons.camera_alt_rounded: () => print('Camera action')},
        {Icons.search: () => print('Search action')},
        {Icons.notifications: () => print('Notifications action')},
      ],
      'boxes': [
        {Icons.star_border_rounded: () => print('Favourite action')},
        {Icons.search: () => print('Search action')},
        {Icons.filter_alt_rounded: () => print('Filter action')},
      ],
      'sections': [
        {Icons.star_border_rounded: () => print('Favourite action')},
        {Icons.search: () => print('Search action')},
        {Icons.filter_alt_rounded: () => print('Filter action')},
      ],
      'items': [
        {Icons.camera_alt_rounded: () => print('Camera action')},
        {Icons.search: () => print('Search action')},
        {Icons.filter_alt_rounded: () => print('Filter action')},
      ],
    };

    return screenActions[currentScreen]?.map((actionMap) {
      IconData icon = actionMap.keys.first;
      Function? action = actionMap[icon];
      return IconButton(
        icon: Icon(icon, color: Colors.black),
        onPressed: () => action!(),
      );
    }).toList() ?? [];
  }
}