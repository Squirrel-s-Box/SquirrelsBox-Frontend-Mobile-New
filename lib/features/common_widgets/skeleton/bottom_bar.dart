part of 'skeleton_app_widget.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});

  final List<BottomItemModel> _items = [
    BottomItemModel(title: "Home", icon: Icons.home, offsetX: 0, offsetY: 0, path: "home"),
    BottomItemModel(title: "Favorites", icon: Icons.star, offsetX: -20, offsetY: 0, path: "favorites"),
    BottomItemModel(title: "Downloads",icon: Icons.file_download_outlined,offsetX: 30,offsetY: 0, path: "downloads"),
    BottomItemModel(title: "Profile", icon: Icons.person, offsetX: 0, offsetY: 0, path: "profile"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: AppColors.ultraLowOrange,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (final item in _items)
            BottomItem(
              item: item,
            ),
        ],
      ),
    );
  }
}
