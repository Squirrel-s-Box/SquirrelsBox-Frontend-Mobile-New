part of 'box_item.dart';

class BoxOptionsIcon extends StatelessWidget {
  const BoxOptionsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        right: 30,
        child: IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () {},
        ));
  }
}
