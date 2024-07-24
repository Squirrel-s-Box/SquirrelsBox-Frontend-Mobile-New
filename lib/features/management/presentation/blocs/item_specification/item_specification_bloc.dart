import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../util/domain/models/response/base_response.dart';
import '../../../domain/models/item_specification.dart';
import '../../../domain/models/requests/item_specification_request.dart';
import '../../../services/item_specification_service.dart';

part 'item_specification_event.dart';
part 'item_specification_state.dart';

class ItemSpecificationBloc extends Bloc<ItemSpecificationEvent, ItemSpecificationState> {
  final ItemSpecificationService specService;
  ItemSpecificationBloc({
    required this.specService
  }) : super(const ItemSpecificationState()) {

    on<AddItemSpec>(_onAddItemSpec);
    on<FetchItemSpecs>(_onFetchItemSpecs);
    on<UpdateItemSpec>(_onUpdateItemSpec);
    on<DeleteItemSpec>(_onDeleteItemSpec);
    on<DeleteItemSpecLocal>(_onDeleteItemSpecLocal);
    on<CancelEdit>(_onCancelEdit);
  }

  Future<void> _onFetchItemSpecs(
      FetchItemSpecs event,
      Emitter<ItemSpecificationState> emit
      ) async {
    emit(state.copyWith(status: ItemSpecificationStatus.loading));

    await emit.forEach<List<ItemSpecification>>(
        specService.getItemSpecList(event.itemId).asStream(),
        onData: (specs) => state.copyWith(
          status: ItemSpecificationStatus.success,
          specifications: specs,
          itemId: event.itemId,
          sectionName: event.sectionName,
          boxName: event.boxName,
        ),
        onError: (_, __) => state.copyWith(
            status: ItemSpecificationStatus.failure
        )
    );
  }

  Future<void> _onAddItemSpec(
      AddItemSpec event,
      Emitter<ItemSpecificationState> emit
      ) async {
    emit(state.copyWith(status: ItemSpecificationStatus.loading));

    await emit.forEach<BaseResponse>(
        specService.addItemSpec(ItemSpecificationRequest(
            specs: event.specs
        )).asStream(),
        onData: (items) => state.copyWith(
          status: ItemSpecificationStatus.success,
        ),
        onError: (e, __) {
          final error = e as DioException;
          return state.copyWith(
            status: ItemSpecificationStatus.failure,
            error: error,
          );
        }
    );

    if(state.status == ItemSpecificationStatus.success) {
      add(FetchItemSpecs(
        itemId: state.itemId,
        itemName: state.itemName,
        sectionName: state.sectionName,
        boxName: state.boxName
      ));
    }

  }

  Future<void> _onUpdateItemSpec(
      UpdateItemSpec event,
      Emitter<ItemSpecificationState> emit
      ) async {
    emit(state.copyWith(status: ItemSpecificationStatus.loading));

    await emit.forEach<BaseResponse>(
        specService.updateItemSpec(ItemSpecificationRequest(
          specs: event.specs
        )
        ).asStream(),
        onData: (specs) {
          for (var spec in event.specs) {
            final index = state.specifications.indexWhere((e) => e.id == spec.id);
            if (index != -1) state.specifications[index] = spec;
          }

          return state.copyWith(
            status: ItemSpecificationStatus.success,
            specifications: state.specifications,
          );
        },
        onError: (e, __) {
          final error = e as DioException;
          return state.copyWith(
            status: ItemSpecificationStatus.failure,
            error: error,
          );
        }
    );
  }

  Future<void> _onDeleteItemSpec(
      DeleteItemSpec event,
      Emitter<ItemSpecificationState> emit
      ) async {
    emit(state.copyWith(status: ItemSpecificationStatus.loading));

    await emit.forEach<BaseResponse>(
        specService.deleteItemSpec(event.itemSpecIds).asStream(),
        onData: (items) {
          state.specifications.removeWhere((spec) => event.itemSpecIds.contains(spec.id));
          return state.copyWith(
            status: ItemSpecificationStatus.success,
            specifications: state.specifications,
          );
        },
        onError: (_, __) => state.copyWith(
            status: ItemSpecificationStatus.failure
        )
    );
  }

  void _onDeleteItemSpecLocal(
      DeleteItemSpecLocal event,
      Emitter<ItemSpecificationState> emit
      ) {
    emit(state.copyWith(
      specifications: state.specifications.where((s) => s != event.spec).toList(),
      specsDeleted: [...state.specsDeleted, event.spec]
    ));
  }

  void _onCancelEdit(
      CancelEdit event,
      Emitter<ItemSpecificationState> emit
      ) {
    emit(state.copyWith(
        specifications: [...state.specifications, ...state.specsDeleted],
        specsDeleted: []
    ));

    //TODO: is necessary to fetch?
    /*add(FetchItemSpecs(
        itemId: state.itemId,
        itemName: state.itemName,
        sectionName: state.sectionName,
        boxName: state.boxName
    ));*/
  }

}