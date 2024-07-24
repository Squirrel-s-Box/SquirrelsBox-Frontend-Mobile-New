import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squirrels_box_2/features/management/presentation/cubits/new_specification_cubit.dart';
import 'package:squirrels_box_2/features/management/presentation/pages/take_picture_screen.dart';

import '../../../../config/router/app_router.dart';
import '../../domain/models/item.dart';
import '../../domain/models/item_specification.dart';
import '../blocs/item/item_bloc.dart';
import '../blocs/item_specification/item_specification_bloc.dart';
import '../widgets/modals/modals.dart';

class ItemSpecificationsPage extends StatefulWidget {
  final String itemId;
  final String itemName;
  final String sectionName;
  final String boxName;

  const ItemSpecificationsPage(
      {required this.itemId,
      required this.itemName,
      required this.sectionName,
      required this.boxName,
      super.key});

  @override
  State<ItemSpecificationsPage> createState() => _ItemSpecificationsPageState();
}

class _ItemSpecificationsPageState extends State<ItemSpecificationsPage> {
  late final int itemId;
  late final Item currentItem;
  late final List<ItemSpecification> newSpecs;

  bool isEditing = false;

  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _subHeaderController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    itemId = int.parse(widget.itemId);
    newSpecs = [];

    currentItem = context.read<ItemBloc>().state.items.firstWhere((i) => i.id == itemId);

    context.read<ItemSpecificationBloc>().add(FetchItemSpecs(
        itemId: itemId,
        itemName: widget.itemName,
        sectionName: widget.sectionName,
        boxName: widget.boxName));

    _codeController.text = currentItem.id.toString();
    _amountController.text = currentItem.amount!;
    _colorController.text = 'Blue';
    _descriptionController.text = currentItem.description!;

    super.initState();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _amountController.dispose();
    _colorController.dispose();
    _descriptionController.dispose();
    _subHeaderController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewSpecificationCubit>(
      create: (context) => NewSpecificationCubit(),
      child: BlocBuilder<ItemSpecificationBloc, ItemSpecificationState>(
          builder: (context, state) {
            switch (state.status) {
              case ItemSpecificationStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ItemSpecificationStatus.failure:
                return const Center(
                  child: Text("An error occurred"),
                );
              case ItemSpecificationStatus.success:
                return _buildItemSpecifications(state.specifications);
              case ItemSpecificationStatus.initial:
                context.read<ItemSpecificationBloc>().add(FetchItemSpecs(
                    itemId: itemId,
                    itemName: widget.itemName,
                    sectionName: widget.sectionName,
                    boxName: widget.boxName));
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
    );
  }

  Widget _buildItemSpecifications(List<ItemSpecification> specs) {
    return BlocBuilder<NewSpecificationCubit, NewSpecificationState>(
      builder: (context, state) {
        final cubit = context.read<NewSpecificationCubit>();
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 200.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          'https://via.placeholder.com/400', // TODO: replace with image or url_image
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (!isEditing)
                        Positioned(
                          bottom: 10.0,
                          right: 10.0,
                          child: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                isEditing = true;
                              });
                            },
                          ),
                        ),
                      if (isEditing)
                        Positioned(
                          bottom: 10.0,
                          right: 50.0,
                          child: IconButton(
                            icon: const Icon(Icons.check, color: Colors.white),
                            onPressed: () {
                              //TODO: validate these operations
                              context.read<ItemSpecificationBloc>().add(UpdateItemSpec(
                                specs: specs
                              ));
                              if (cubit.state.specs.isNotEmpty) {
                                context.read<ItemSpecificationBloc>().add(AddItemSpec(
                                    specs: cubit.state.specs
                                ));
                              }
                              if (cubit.state.specIds.isNotEmpty) {
                                context.read<ItemSpecificationBloc>().add(DeleteItemSpec(
                                    itemSpecIds: cubit.state.specIds
                                ));
                              }
                              cubit.resetCubit();

                              setState(() {
                                isEditing = false;
                              });
                            },
                          ),
                        ),
                      if (isEditing)
                        Positioned(
                          bottom: 10.0,
                          right: 10.0,
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () {
                              context.read<ItemSpecificationBloc>().add(const CancelEdit());
                              cubit.resetCubit();
                              setState(() {
                                isEditing = false;
                              });
                            },
                          ),
                        ),
                      if (isEditing)
                        Positioned(
                          bottom: 10.0,
                          left: 10.0,
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt_rounded, color: Colors.white),
                            onPressed: () async {
                              context.read<RouterCubit>().goCamera();
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.boxName,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(widget.sectionName,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text(widget.itemName,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      const Text('ID (Product Code)',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(itemId.toString()),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Amount',
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                isEditing
                                    ? TextFormField(
                                        controller: _amountController,
                                        keyboardType: TextInputType.number,
                                      )
                                    : Text(_amountController.text),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Color',
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                Row(
                                  children: [
                                    const Text('Blue'),
                                    const SizedBox(width: 5),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      color: Colors.blue,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text('Description',
                          style: TextStyle(fontWeight: FontWeight.bold)
                      ),
                      isEditing
                          ? TextField(
                              controller: _descriptionController,
                              maxLines: null,
                            )
                          : Text(_descriptionController.text),
                      const SizedBox(height: 10),
                      Flex(
                        direction: Axis.vertical, children: [_buildSpecs(context, specs, false)]
                      ),
                      const SizedBox(height: 10),
                      Flex(
                        direction: Axis.vertical, children: [
                          _buildSpecs(context, cubit.state.specs, true)
                        ] // New Specifications
                      ),
                      const SizedBox(height: 10),
                      if (isEditing)
                        AddSpecificationModal(itemId: itemId),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSpecs(BuildContext context, List<ItemSpecification> specs, bool newSpec) => Column(
    children: specs.map((spec) {
      spec.controller.text = spec.value!;
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(labelText: spec.name),
                  controller: spec.controller,
                  enabled: isEditing,
                  keyboardType: spec.type == 'Text'
                      ? TextInputType.text
                      : TextInputType.number,
                  onChanged: (value) {
                    spec = spec.copyWith(value: value);
                  },
                ),
              ),
              if (isEditing)
                IconButton(
                  onPressed: () {
                    if (newSpec) {
                      context.read<NewSpecificationCubit>().deleteNewSpec(spec);
                    } else {
                      context.read<NewSpecificationCubit>().deleteSpec(spec.id!);
                      context.read<ItemSpecificationBloc>().add(DeleteItemSpecLocal(spec: spec));
                    }
                  },
                  icon: const Icon(Icons.delete)
                )
            ],
          ),
          const SizedBox(height: 10)
        ],
      );
    }).toList(),
  );
}
