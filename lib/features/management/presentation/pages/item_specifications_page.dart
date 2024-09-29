import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squirrels_box_2/features/management/presentation/cubits/new_specification_cubit.dart';

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
  late final ItemBloc itemBloc;
  late final ItemSpecificationBloc specificationBloc;

  late final int itemId;
  late final Item currentItem;

  late Item itemEdited;

  bool isEditing = false;
  String? photoPath;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _subHeaderController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    itemId = int.parse(widget.itemId);

    itemBloc = context.read<ItemBloc>();
    currentItem = itemBloc.state.items.firstWhere((i) => i.id == itemId);
    itemEdited = currentItem.copyWith();

    specificationBloc = context.read<ItemSpecificationBloc>();

    specificationBloc.add(FetchItemSpecs(
        itemId: itemId,
        itemName: widget.itemName,
        sectionName: widget.sectionName,
        boxName: widget.boxName));

    _nameController.text = itemEdited.name!;
    _codeController.text = itemEdited.id.toString();
    _amountController.text = itemEdited.amount!;
    _colorController.text = 'Blue';
    _descriptionController.text = itemEdited.description!;

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
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
                itemEdited = itemEdited.copyWith(specificationList: state.specifications);
                return _buildItemSpecifications(state.specifications);
              case ItemSpecificationStatus.initial:
                specificationBloc.add(FetchItemSpecs(
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
                        child: photoPath != null
                          ? Image.file(
                            File(photoPath!),
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fitWidth,
                          )
                          : Image.network(itemEdited.itemPhoto!.isEmpty
                            ? 'https://via.placeholder.com/400' // TODO: replace with default image
                            : itemEdited.itemPhoto!,
                            fit: BoxFit.cover,
                        ),
                      ),
                      if (isEditing) ..._editActionsButtons(specs, cubit),
                      if (!isEditing) ..._actionsButtons(),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: isEditing
                      ? _editItemInformation([...specs], cubit)
                      : _itemInformation(specs, cubit),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _actionsButtons() {
    return <Widget>[
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
    ];
  }

  List<Widget> _editActionsButtons(List<ItemSpecification> specs, NewSpecificationCubit cubit) {
    return <Widget>[
      Positioned(
        bottom: 10.0,
        right: 50.0,
        child: IconButton(
          icon: const Icon(Icons.check, color: Colors.white),
          onPressed: () {
            //Item operations
            if (_nameController.text != currentItem.name || _amountController.text != currentItem.amount.toString() ||
              _descriptionController.text != currentItem.description  || photoPath != null) {
              itemBloc.add(UpdateItem(
                item: currentItem.copyWith(
                  name: _nameController.text,
                  amount: _amountController.text,
                  description: _descriptionController.text
                ),
                photoPath: photoPath ?? ''
              ));
            }

            //Spec operations
            specificationBloc.add(UpdateItemSpec(
                specs: specs
            ));
            if (cubit.state.specs.isNotEmpty) {
              specificationBloc.add(AddItemSpec(
                  specs: cubit.state.specs
              ));
            }
            if (cubit.state.specIds.isNotEmpty) {
              specificationBloc.add(DeleteItemSpec(
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
      Positioned(
        bottom: 10.0,
        right: 10.0,
        child: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            itemEdited = currentItem.copyWith();
            itemEdited = itemEdited.copyWith(specificationList: [...specs]);
            cubit.resetCubit();
            setState(() {
              isEditing = false;
            });
          },
        ),
      ),
      Positioned(
        bottom: 10.0,
        left: 10.0,
        child: IconButton(
          icon: const Icon(Icons.camera_alt_rounded, color: Colors.white),
          onPressed: () async {
            photoPath = await context.read<RouterCubit>().goCamera();
            setState(() {});
          },
        ),
      ),
    ];
  }

  Column _itemInformation(List<ItemSpecification> specs, NewSpecificationCubit cubit) => Column(
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
                const Text('Amount', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(_amountController.text),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Color', style: TextStyle(fontWeight: FontWeight.bold)),
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
      const Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
      Text(_descriptionController.text),
      const SizedBox(height: 10),
      Flex(
        direction: Axis.vertical, children: <Widget>[_buildSpecs(specs)]
      ),
      const SizedBox(height: 10),
    ],
  );

  Column _editItemInformation(List<ItemSpecification> specs, NewSpecificationCubit cubit) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(widget.boxName,
          style: const TextStyle(fontWeight: FontWeight.bold)),
      Text(widget.sectionName,
          style: const TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      /*Text(widget.itemName,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold)),*/
      const Text('Item name', style: TextStyle(fontWeight: FontWeight.bold)),
      TextFormField(controller: _nameController, ),
      const SizedBox(height: 15),
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
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                ),
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
      TextField(
        controller: _descriptionController,
        maxLines: null,
      ),
      const SizedBox(height: 10),
      Flex(
        direction: Axis.vertical, children: [
          _buildEditSpecs(cubit, itemEdited.specificationList!, false)
        ]
      ),
      const SizedBox(height: 10),
      Flex(
        direction: Axis.vertical, children: [
          _buildEditSpecs(cubit, cubit.state.specs, true)
        ] // New Specifications
      ),
      const SizedBox(height: 10),
      AddSpecificationModal(itemId: itemId),
    ],
  );


  Column _buildSpecs(List<ItemSpecification> specs) => Column(
    children: specs.map((spec) {
      spec.controller.text = spec.value!;
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: spec.name,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)
                  ),
                  controller: spec.controller,
                  readOnly: true,
                  keyboardType: spec.type == 'Text'
                      ? TextInputType.text
                      : TextInputType.number,
                  onChanged: (value) => spec = spec.copyWith(value: value),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10)
        ],
      );
    }).toList(),
  );

  Column _buildEditSpecs(NewSpecificationCubit cubit, List<ItemSpecification> specs, bool newSpec) => Column(
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
                  keyboardType: spec.type == 'Text'
                      ? TextInputType.text
                      : TextInputType.number,
                  onChanged: (value) => spec = spec.copyWith(value: value),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (newSpec) {
                    cubit.deleteNewSpec(spec);
                  } else {
                    itemEdited = itemEdited.copyWith(specificationList: itemEdited.specificationList!.where((s) => s != spec).toList());
                    cubit.deleteSpec(spec.id!);
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
