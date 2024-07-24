part of 'new_specification_cubit.dart';

class NewSpecificationState extends Equatable {
  final List<ItemSpecification> specs;
  final List<int> specIds;

  const NewSpecificationState({
    this.specs = const [],
    this.specIds = const [],
  });

  NewSpecificationState copyWith({
    List<ItemSpecification>? specs,
    List<int>? specIds,
  }) => NewSpecificationState(
    specs: specs ?? this.specs,
    specIds: specIds ?? this.specIds,
  );

  @override
  List<Object?> get props => [specs, specIds];
}