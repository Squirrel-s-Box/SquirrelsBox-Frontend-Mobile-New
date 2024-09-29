part of 'item_bloc.dart';

abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object?> get props => [];
}

class AddItem extends ItemEvent {
  final String boxName;
  final int sectionId;
  final String sectionName;

  final String name;
  final String description;
  final String amount;
  final String photo;

  final String photoPath;

  const AddItem({
    required this.boxName,
    required this.sectionName,
    required this.sectionId,
    required this.name,
    required this.description,
    required this.amount,
    required this.photo,
    required this.photoPath,
  });

  @override
  List<Object> get props => [
    sectionId, sectionName, boxName,
    name,
    description,
    amount,
    photo,
    photoPath,
  ];
}

class FetchItems extends ItemEvent {
  final int sectionId;
  final String sectionName;
  final String boxName;

  const FetchItems({
    required this.sectionId,
    required this.sectionName,
    required this.boxName,
  });

  @override
  List<Object?> get props => [sectionId, sectionName, boxName];
}

class UpdateItem extends ItemEvent {
  final Item item;
  final String photoPath;

  const UpdateItem({required this.item, required this.photoPath});

  @override
  List<Object?> get props => [item, photoPath];
}

class DeleteItem extends ItemEvent {
  final int itemId;

  const DeleteItem({required this.itemId});

  @override
  List<Object?> get props => [itemId];
}