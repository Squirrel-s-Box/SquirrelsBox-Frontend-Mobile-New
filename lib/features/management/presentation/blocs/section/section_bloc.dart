import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../util/domain/models/response/base_response.dart';
import '../../../domain/models/requests/section_request.dart';
import '../../../domain/models/section.dart';
import '../../../services/section_service.dart';

part 'section_event.dart';
part 'section_state.dart';

class SectionBloc extends Bloc<SectionEvent, SectionState> {
  final SectionService sectionService;

  SectionBloc({
    required this.sectionService
  }) : super(const SectionState()) {

    on<AddSection>(_onAddSection);
    on<FetchSections>(_onFetchSections);
    on<UpdateSection>(_onUpdateSection);
    on<DeleteSection>(_onDeleteSection);
  }

  Future<void> _onFetchSections(
      FetchSections event,
      Emitter<SectionState> emit
      ) async {
    emit(state.copyWith(status: SectionStatus.loading));

    await emit.forEach<List<Section>>(
      sectionService.getSectionList(event.boxId).asStream(),
      onData: (sections) => state.copyWith(
        status: SectionStatus.success,
        sections: sections,
        boxId: event.boxId,
        boxName: event.boxName,
      ),
      onError: (_, __) => state.copyWith(
        status: SectionStatus.failure
      )
    );
  }

  Future<void> _onAddSection(
      AddSection event,
      Emitter<SectionState> emit
      ) async {
    emit(state.copyWith(status: SectionStatus.loading));

    await emit.forEach<BaseResponse>(
        sectionService.addSection(
          SectionRequest(
            boxId: event.boxId,
            section: Section(
              name: event.name,
              color: event.color
            )
          )
        ).asStream(),
        onData: (sections) => state.copyWith(
          status: SectionStatus.success,
        ),
        onError: (e, st) {
          return state.copyWith(
              status: SectionStatus.failure
          );
        }
    );

    if(state.status == SectionStatus.success) {
      add(FetchSections(boxId: event.boxId, boxName: event.boxName));
    }

  }

  Future<void> _onUpdateSection(
      UpdateSection event,
      Emitter<SectionState> emit
      ) async {
    emit(state.copyWith(status: SectionStatus.loading));

    await emit.forEach<BaseResponse>(
        sectionService.updateSection(SectionRequest(
          section: event.section,
          boxId: state.boxId
        )).asStream(),
        onData: (sections) {
          state.sections[state.sections.indexWhere((e) => e.id == event.section.id)] = event.section;
          return state.copyWith(
            status: SectionStatus.success,
            sections: state.sections,
          );
        },
        onError: (_, __) => state.copyWith(
            status: SectionStatus.failure
        )
    );
  }

  Future<void> _onDeleteSection(
      DeleteSection event,
      Emitter<SectionState> emit
      ) async {
    emit(state.copyWith(status: SectionStatus.loading));

    await emit.forEach<BaseResponse>(
        sectionService.deleteSection(event.sectionId).asStream(),
        onData: (sections) {
          state.sections.removeWhere((e) => e.id == event.sectionId);
          return state.copyWith(
            status: SectionStatus.success,
            sections: state.sections,
          );
        },
        onError: (_, __) => state.copyWith(
            status: SectionStatus.failure
        )
    );
  }

}
