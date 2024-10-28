import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squirrels_box_2/config/router/app_router.dart';
import 'package:squirrels_box_2/config/theme/colors.dart';
import 'package:squirrels_box_2/features/profile/presentation/widgets/storage_widget.dart';
import 'package:squirrels_box_2/features/widgets/app_widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = context.read<RouterCubit>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PrincipalTitle(title: "Profile"),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const PrincipalTitle(title: "General Information"),
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
          ]),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  NormalText(title: "Username"),
                  NormalText(title: "Diego535")
                ],
              ),
              Column(
                children: [
                  NormalText(title: "Birthday"),
                  NormalText(title: "05/04/03")
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          const PrincipalTitle(title: "Storage"),
          const SizedBox(height: 10),
          const StorageWidget(
              name: "Boxes", icon: Icons.book, boxesTotals: 6, boxesUsed: 2),
          const SizedBox(height: 7),
          const StorageWidget(
              name: "Sections",
              icon: Icons.bookmarks_sharp,
              boxesTotals: 6,
              boxesUsed: 3),
          const SizedBox(height: 7),
          const StorageWidget(
              name: "Items", icon: Icons.apple, boxesTotals: 6, boxesUsed: 6),
          const SizedBox(height: 7),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.midOrange,
              ),
              onPressed: () {}, child: const NormalText(title: "Upgrade"))
        ],
      ),
    );
  }
}
