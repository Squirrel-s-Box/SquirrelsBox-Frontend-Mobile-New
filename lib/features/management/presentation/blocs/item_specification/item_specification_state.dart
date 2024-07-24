part of 'item_specification_bloc.dart';

enum ItemSpecificationStatus { initial, loading, success, failure }

class ItemSpecificationState extends Equatable {
  final ItemSpecificationStatus status;
  final List<ItemSpecification> specifications;
  final List<ItemSpecification> specsDeleted;
  final int itemId;
  final String itemName;
  final String sectionName;
  final String boxName;
  final DioException? error;

  const ItemSpecificationState({
    this.status = ItemSpecificationStatus.initial,
    this.specifications = const [],
    this.specsDeleted = const [],
    this.itemId = 0,
    this.itemName = '',
    this.sectionName = '',
    this.boxName = '',
    this.error,
  });

  ItemSpecificationState copyWith({
    ItemSpecificationStatus? status,
    List<ItemSpecification>? specifications,
    List<ItemSpecification>? specsDeleted,
    int? itemId,
    String? itemName,
    String? sectionName,
    String? boxName,
    DioException? error,
  }) => ItemSpecificationState(
      status: status ?? this.status,
      specifications: specifications ?? this.specifications,
      specsDeleted: specsDeleted ?? this.specsDeleted,
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      sectionName: sectionName ?? this.sectionName,
      boxName: boxName ?? this.boxName,
      error: error ?? this.error,
  );

  @override
  List<Object?> get props => [
    status,
    specifications,
    specsDeleted,
    itemId,
    itemName,
    sectionName,
    boxName,
    error
  ];
}
