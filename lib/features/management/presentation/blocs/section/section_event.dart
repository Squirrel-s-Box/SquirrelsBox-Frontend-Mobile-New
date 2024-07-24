part of 'section_bloc.dart';

abstract class SectionEvent extends Equatable {
  const SectionEvent();

  @override
  List<Object?> get props => [];
}

class AddSection extends SectionEvent {
  final int boxId;
  final String boxName;
  final String name;
  final String color;

  const AddSection({
    required this.boxId,
    required this.boxName,
    required this.name,
    required this.color
  });

  @override
  List<Object> get props => [boxId, boxName, name, color];
}

class FetchSections extends SectionEvent {
  final int boxId;
  final String boxName;
  const FetchSections({required this.boxId, required this.boxName});

  @override
  List<Object?> get props => [boxId, boxName];
}

class UpdateSection extends SectionEvent {
  final Section section;

  const UpdateSection({required this.section});

  @override
  List<Object?> get props => [section];
}

class DeleteSection extends SectionEvent {
  final int sectionId;

  const DeleteSection({required this.sectionId});

  @override
  List<Object?> get props => [sectionId];
}