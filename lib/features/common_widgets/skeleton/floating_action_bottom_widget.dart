part of 'skeleton_app_widget.dart';

class FloatingActionBottomWidget extends StatelessWidget {
  final String routeName;
  const FloatingActionBottomWidget({required this.routeName, super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = context.read<RouterCubit>();
    final bool manage = routeName == 'boxes' || routeName == 'sections' || routeName == 'items';

    return FloatingActionButton.extended(
      backgroundColor: routeName == 'boxes'
          ? AppColors.midOrange
          : AppColors.whiteBackground,
      shape: CircleBorder(
          side: BorderSide(
              color: manage
                  ? AppColors.ultraLowOrange
                  : AppColors.midOrange)
      ),
      onPressed: () {
        switch(routeName) {
          case 'boxes':
            showDialog(context: context,
              builder: (context) => const AddBoxModal(),
            );
            break;
          case 'sections':
            showDialog(context: context,
              builder: (context) => const AddSectionModal(),
            );
            break;
          case 'items':
            showDialog(context: context,
              builder: (context) => const AddItemModal(),
            );
            break;
          default:
            appRouter.goMyBoxes();
        }
      },
      elevation: 0,
      extendedPadding: const EdgeInsets.symmetric(horizontal: 3),
      label: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.translate(
              offset: const Offset(0, 10),
              child: Icon(manage
                    ? Icons.add
                    : Icons.folder_open,
                size: 30,
                color: manage
                    ? AppColors.darkBlue
                    : AppColors.midOrange,
              )
            ),
            Transform.translate(
              offset: const Offset(0, 27),
              child: AutoSizeText(routeName == 'sections' ? 'My Sections'
                  : routeName == 'items' ? 'My Items'
                  : 'My boxes',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: manage
                      ? AppColors.darkBlue
                      : AppColors.midOrange,
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}


