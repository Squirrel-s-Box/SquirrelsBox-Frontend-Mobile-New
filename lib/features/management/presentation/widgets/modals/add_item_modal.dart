import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../blocs/item/item_bloc.dart';

class AddItemModal extends StatefulWidget {
  const AddItemModal({
    super.key,
  });

  @override
  State<AddItemModal> createState() => _AddItemModalState();
}

class _AddItemModalState extends State<AddItemModal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  String photoPath = '';

  late final ItemBloc itemBloc;

  @override
  void initState() {
    itemBloc = context.read<ItemBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Add your Item',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(itemBloc.state.sectionName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(itemBloc.state.boxName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Item name'),
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                controller: _descriptionController,
                validator: (value) {
                  if (value == null) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  photoPath = await _selectPhoto();
                },
                child: const Text('Select photo'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Add Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<ItemBloc>().add(AddItem(
        boxName: itemBloc.state.boxName,
        sectionName: itemBloc.state.sectionName,
        sectionId: itemBloc.state.sectionId,
        name: _nameController.text,
        description: _descriptionController.text,
        amount: _amountController.text,
        photo: '',
        photoPath: photoPath,
      ));
      Navigator.of(context).pop();
    }
  }

  Future<String> _selectPhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image?.path ?? '';
  }



}