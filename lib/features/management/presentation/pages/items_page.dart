import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common_widgets/common_widgets.dart';
import '../../domain/models/item.dart';
import '../blocs/item/item_bloc.dart';
import '../widgets/item_widget.dart';


class ItemsPage extends StatefulWidget {
  final String sectionId;
  final String sectionName;
  final String boxName;

  const ItemsPage({
    required this.sectionId,
    required this.sectionName,
    required this.boxName,
    super.key
  });

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  late final int sectionId;

  @override
  void initState() {
    sectionId = int.parse(widget.sectionId);
    context.read<ItemBloc>().add(FetchItems(
      sectionId: sectionId,
      sectionName: widget.sectionName,
      boxName: widget.boxName
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemBloc, ItemState>(
      builder: (context, state) {
        switch (state.status) {
          case ItemStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ItemStatus.failure:
            return const Center(
              child: Text("An error occurred"),
            );
          case ItemStatus.success:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PrincipalTitle(title: 'My Items'),
                Expanded(
                  child: _buildItems(state.items),
                )
              ],
            );
          case ItemStatus.initial:
            context.read<ItemBloc>().add(FetchItems(
              sectionId: sectionId,
              sectionName: widget.sectionName,
              boxName: widget.boxName
            ));
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }

  Widget _buildItems(List<Item> items) =>
      ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => ItemWidget(item: items[index]),
      );

}
