import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/item_specification.dart';
import '../../cubits/new_specification_cubit.dart';

class AddSpecificationModal extends StatefulWidget {
  final int itemId;
  const AddSpecificationModal({
    required this.itemId,
    super.key
  });

  @override
  State<AddSpecificationModal> createState() => _AddSpecificationModalState();
}

class _AddSpecificationModalState extends State<AddSpecificationModal> {
  final _formKey = GlobalKey<FormState>();
  late final NewSpecificationCubit specCubit;
  bool viewPreviewSpec = false;
  String? typeSpec;

  final TextEditingController _subHeaderController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    specCubit = context.read<NewSpecificationCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _subHeaderController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          const Text('Personalized spec',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)
          ),
          const SizedBox(height: 5),
          TextFormField(
            decoration: const InputDecoration(labelText: 'SubHeader name'),
            controller: _subHeaderController,
            onChanged: (value) {
              setState(() {
                viewPreviewSpec = true && viewPreviewSpec;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          DropdownButton<String>(
            items: const [
              DropdownMenuItem<String>(
                value: 'Number',
                child: Text('Number'),
              ),
              DropdownMenuItem<String>(
                value: 'Text',
                child: Text('Text'),
              ),
            ],
            onChanged: (String? newValue) {
              setState(() {
                typeSpec = newValue;
              });
            },
            hint: Text(typeSpec ?? 'Type'),
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Content'),
            controller: _contentController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a value';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          const Text('=', style: TextStyle(fontSize: 32)),
          TextButton.icon(
            onPressed: () {
              setState(() {
                viewPreviewSpec = !viewPreviewSpec;
              });
            },
            icon: Icon(viewPreviewSpec? Icons.visibility_off : Icons.visibility),
            label: const Text('View Spec')
          ),
          if (viewPreviewSpec)
            TextFormField(
              decoration: InputDecoration(
                labelText: _subHeaderController.text,
              ),
              controller: _contentController,
              enabled: false,
            ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Add Specification'),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      typeSpec ??= 'Text';
      specCubit.addNewSpec(ItemSpecification(
        itemId: widget.itemId,
        name: _subHeaderController.text,
        type: typeSpec,
        value: _contentController.text,
      ));
      resetValues();
    }
  }

  void resetValues() {
    _subHeaderController.text = '';
    typeSpec = null;
    _contentController.text = '';
  }

}