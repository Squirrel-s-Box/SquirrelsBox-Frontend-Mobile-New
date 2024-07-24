part of 'item_specification_bloc.dart';

abstract class ItemSpecificationEvent extends Equatable {
  const ItemSpecificationEvent();

  @override
  List<Object?> get props => [];
}

class AddItemSpec extends ItemSpecificationEvent {
  final List<ItemSpecification> specs;

  const AddItemSpec({
    required this.specs
  });

  @override
  List<Object> get props => [specs];
}

class FetchItemSpecs extends ItemSpecificationEvent {
  final int itemId;
  final String itemName;
  final String sectionName;
  final String boxName;

  const FetchItemSpecs({
    required this.itemId,
    required this.itemName,
    required this.sectionName,
    required this.boxName,
  });

  @override
  List<Object?> get props => [itemId, itemName, sectionName, boxName];
}

class UpdateItemSpec extends ItemSpecificationEvent {
  final List<ItemSpecification> specs;

  const UpdateItemSpec({required this.specs});

  @override
  List<Object?> get props => [specs];
}

class DeleteItemSpec extends ItemSpecificationEvent {
  final List<int> itemSpecIds;

  const DeleteItemSpec({required this.itemSpecIds});

  @override
  List<Object?> get props => [itemSpecIds];
}

class DeleteItemSpecLocal extends ItemSpecificationEvent {
  final ItemSpecification spec;

  const DeleteItemSpecLocal({required this.spec});

  @override
  List<Object?> get props => [spec];
}

class CancelEdit extends ItemSpecificationEvent {
  const CancelEdit();

  @override
  List<Object?> get props => [];
}