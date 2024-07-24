part of 'box_bloc.dart';

abstract class BoxEvent extends Equatable {
  const BoxEvent();

  @override
  List<Object?> get props => [];
}

class AddBox extends BoxEvent {
  final String userCode;
  final String name;

  const AddBox({
    required this.userCode,
    required this.name,
  });

  @override
  List<Object> get props => [userCode, name];
}

class FetchBoxes extends BoxEvent {
  final String userCode;
  const FetchBoxes({required this.userCode});

  @override
  List<Object?> get props => [userCode];
}

class UpdateBox extends BoxEvent {
  final Box box;

  const UpdateBox({required this.box});

  @override
  List<Object?> get props => [box];
}

class DeleteBox extends BoxEvent {
  final int boxId;

  const DeleteBox({required this.boxId});

  @override
  List<Object?> get props => [boxId];
}