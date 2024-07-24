part of 'item_bloc.dart';

enum ItemStatus { initial, loading, success, failure }

class ItemState extends Equatable {
  final ItemStatus status;
  final List<Item> items;
  final String boxName;
  final String sectionName;
  final int sectionId;
  final DioException? error;

  const ItemState({
    this.status = ItemStatus.initial,
    this.items = const [],
    this.boxName = '',
    this.sectionName = '',
    this.sectionId = 0,
    this.error,
  });

  ItemState copyWith({
    ItemStatus? status,
    List<Item>? items,
    String? boxName,
    String? sectionName,
    int? sectionId,
    DioException? error,
  }) => ItemState(
      status: status ?? this.status,
      items: items ?? this.items,
      boxName: boxName ?? this.boxName,
      sectionName: sectionName ?? this.sectionName,
      sectionId: sectionId ?? this.sectionId,
      error: error ?? this.error,
  );

  @override
  List<Object?> get props => [status, items, boxName, sectionName, sectionId, error];
}
