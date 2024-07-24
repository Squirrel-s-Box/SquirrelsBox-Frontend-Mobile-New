part of 'my_activity_widget.dart';

class MyActivityRegister extends StatelessWidget {
  const MyActivityRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TileActivityRegister(date: DateTime.now()),
      TileActivityRegister(date: DateTime.now()),
      TileActivityRegister(date: DateTime.now()),
      TileActivityRegister(date: DateTime.now()),
    ]);
  }
}
