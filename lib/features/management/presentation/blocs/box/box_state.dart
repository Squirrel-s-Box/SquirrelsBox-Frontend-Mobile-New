part of 'box_bloc.dart';

enum BoxStatus { initial, loading, success, failure }

class BoxState extends Equatable {
  final BoxStatus status;
  final List<Box> boxes;

  const BoxState({
    this.status = BoxStatus.initial,
    this.boxes = const [],
  });

  BoxState copyWith({
    BoxStatus? status,
    List<Box>? boxes
  }) => BoxState(
    status: status ?? this.status,
    boxes: boxes ?? this.boxes
  );

  @override
  List<Object?> get props => [status, boxes];
}

