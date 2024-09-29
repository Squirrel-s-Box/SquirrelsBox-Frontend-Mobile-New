import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../util/domain/models/response/base_response.dart';
import '../../../domain/models/box.dart';
import '../../../services/box_service.dart';

part 'box_event.dart';
part 'box_state.dart';

class BoxBloc extends Bloc<BoxEvent, BoxState> {
  final BoxService boxService;

  BoxBloc({
    required this.boxService
  }) : super(const BoxState()) {

    on<AddBox>(_onAddBox);
    on<FetchBoxes>(_onFetchBoxes);
    on<UpdateBox>(_onUpdateBox);
    on<DeleteBox>(_onDeleteBox);
  }

  Future<void> _onFetchBoxes(
    FetchBoxes event,
    Emitter<BoxState> emit
  ) async {
    emit(state.copyWith(status: BoxStatus.loading));

    await emit.forEach<List<Box>>(
      boxService.getBoxList(event.userCode).asStream(),
      onData: (boxes) => state.copyWith(
        status: BoxStatus.success,
        boxes: boxes,
      ),
      onError: (_, __) => state.copyWith(
        status: BoxStatus.failure
      )
    );
  }

  Future<void> _onAddBox(
      AddBox event,
      Emitter<BoxState> emit
      ) async {
    emit(state.copyWith(status: BoxStatus.loading));

    await emit.forEach<BaseResponse>(
        boxService.addBox(
            Box(
              name: event.name
            ), event.userCode
        ).asStream(),
        onData: (boxes) => state.copyWith(
          status: BoxStatus.success,
        ),
        onError: (_, __) => state.copyWith(
            status: BoxStatus.failure
        )
    );

    if(state.status == BoxStatus.success) {
      add(FetchBoxes(userCode: event.userCode));
    }

  }

  Future<void> _onUpdateBox(
      UpdateBox event,
      Emitter<BoxState> emit
      ) async {
    emit(state.copyWith(status: BoxStatus.loading));

    await emit.forEach<BaseResponse>(
        boxService.updateBox(event.box).asStream(),
        onData: (boxes) {
          state.boxes[state.boxes.indexWhere((e) => e.id == event.box.id)] = event.box;
          return state.copyWith(
            status: BoxStatus.success,
            boxes: state.boxes,
          );
        },
        onError: (_, __) => state.copyWith(
            status: BoxStatus.failure
        )
    );
  }

  Future<void> _onDeleteBox(
      DeleteBox event,
      Emitter<BoxState> emit
      ) async {
    emit(state.copyWith(status: BoxStatus.loading));

    await emit.forEach<BaseResponse>(
        boxService.deleteBox(event.boxId).asStream(),
        onData: (boxes) {
          state.boxes.removeWhere((e) => e.id == event.boxId);
          return state.copyWith(
            status: BoxStatus.success,
            boxes: state.boxes,
          );
        },
        onError: (_, __) => state.copyWith(
            status: BoxStatus.failure
        )
    );
  }

}
