import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/models/item_specification.dart';

part 'new_specification_state.dart';

class NewSpecificationCubit extends Cubit<NewSpecificationState> {
  NewSpecificationCubit() : super(const NewSpecificationState());

  void addNewSpec(ItemSpecification spec) {
    emit(state.copyWith(specs: [...state.specs, spec]));
  }

  void deleteNewSpec(ItemSpecification spec) {
    emit(state.copyWith(
      specs: state.specs.where((s) => s != spec).toList()
    ));
  }

  void deleteSpec(int id) {
    emit(state.copyWith(specIds: [...state.specIds, id]));
  }

  void resetCubit() {
    emit(state.copyWith(specs: [], specIds: []));
  }

}
