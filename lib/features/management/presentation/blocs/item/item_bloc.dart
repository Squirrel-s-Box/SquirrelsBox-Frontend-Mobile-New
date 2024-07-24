import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../util/domain/models/response/base_response.dart';
import '../../../domain/models/item.dart';
import '../../../domain/models/requests/item_request.dart';
import '../../../services/item_service.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemService itemService;
  ItemBloc({
    required this.itemService
  }) : super(const ItemState()) {

    on<AddItem>(_onAddItem);
    on<FetchItems>(_onFetchItems);
    on<UpdateItem>(_onUpdateItem);
    on<DeleteItem>(_onDeleteItem);
  }

  Future<void> _onFetchItems(
      FetchItems event,
      Emitter<ItemState> emit
      ) async {
    emit(state.copyWith(status: ItemStatus.loading));

    await emit.forEach<List<Item>>(
        itemService.getItemsList(event.sectionId).asStream(),
        onData: (items) => state.copyWith(
          status: ItemStatus.success,
          items: items,
          boxName: event.boxName,
          sectionName: event.sectionName,
          sectionId: event.sectionId,
        ),
        onError: (_, __) => state.copyWith(
            status: ItemStatus.failure
        )
    );
  }

  Future<void> _onAddItem(
      AddItem event,
      Emitter<ItemState> emit
      ) async {
    emit(state.copyWith(status: ItemStatus.loading));

    await emit.forEach<BaseResponse>(
        itemService.addItem(ItemRequest(
            sectionId: event.sectionId,
            item: Item(
              name: event.name,
              description: event.description,
              amount: event.amount,
              itemPhoto: event.photo,
            )
        )).asStream(),
        onData: (items) => state.copyWith(
          status: ItemStatus.success,
        ),
        onError: (e, __) {
          final error = e as DioException;
          return state.copyWith(
            status: ItemStatus.failure,
            error: error,
          );
        }
    );

    if(state.status == ItemStatus.success) {
      add(FetchItems(
        sectionId: event.sectionId,
        sectionName: event.sectionName,
        boxName: event.boxName
      ));
    }

  }

  Future<void> _onUpdateItem(
      UpdateItem event,
      Emitter<ItemState> emit
      ) async {
    emit(state.copyWith(status: ItemStatus.loading));

    await emit.forEach<BaseResponse>(
        itemService.updateItem(ItemRequest(
          item: event.item,
          sectionId: state.sectionId
        )).asStream(),
        onData: (items) {
          state.items[state.items.indexWhere((e) => e.id == event.item.id)] = event.item;
          return state.copyWith(
            status: ItemStatus.success,
            items: state.items,
          );
        },
        onError: (e, __) {
          final error = e as DioException;
          return state.copyWith(
            status: ItemStatus.failure,
            error: error,
          );
        }
    );
  }

  Future<void> _onDeleteItem(
      DeleteItem event,
      Emitter<ItemState> emit
      ) async {
    emit(state.copyWith(status: ItemStatus.loading));

    await emit.forEach<BaseResponse>(
        itemService.deleteItem(event.itemId).asStream(),
        onData: (items) {
          state.items.removeWhere((e) => e.id == event.itemId);
          return state.copyWith(
            status: ItemStatus.success,
            items: state.items,
          );
        },
        onError: (_, __) => state.copyWith(
            status: ItemStatus.failure
        )
    );
  }

}