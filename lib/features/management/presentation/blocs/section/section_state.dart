part of 'section_bloc.dart';

enum SectionStatus { initial, loading, success, failure }

class SectionState extends Equatable {
  final SectionStatus status;
  final List<Section> sections;
  final int boxId;
  final String boxName;

  const SectionState({
    this.status = SectionStatus.initial,
    this.sections = const [],
    this.boxId = 0,
    this.boxName = '',
  });

  SectionState copyWith({
    SectionStatus? status,
    List<Section>? sections,
    int? boxId,
    String? boxName,
  }) => SectionState(
      status: status ?? this.status,
      sections: sections ?? this.sections,
      boxId: boxId ?? this.boxId,
      boxName: boxName ?? this.boxName,
  );

  @override
  List<Object?> get props => [status, sections, boxId, boxName];
}
