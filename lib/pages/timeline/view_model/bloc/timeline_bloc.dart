import 'package:bloc/bloc.dart';
import 'package:instagram_clone/pages/timeline/model/timeline.dart';
import 'package:instagram_clone/pages/timeline/repository/timeline_repository.dart';
import 'package:instagram_clone/utils/locator.dart';
import 'package:meta/meta.dart';

part 'timeline_event.dart';
part 'timeline_state.dart';

TimelineRepository _timelineRepository = locator<TimelineRepository>();

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  TimelineBloc() : super(TimelineInitial()) {
    on<GetTimeline>((event, emit) async {
      emit(TimelineLoading());

      final timeline = await _timelineRepository.getTimeline();

      if (timeline is Timeline) {
        emit(TimelineSuccess(timeline: timeline));
      } else {
        emit(TimelineFailure(error: timeline));
      }
    });

    on<ClearTimeline>((event, emit) {
      emit(TimelineInitial());
    });
  }
}
