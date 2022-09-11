import 'package:bloc/bloc.dart';
import 'package:instagram_clone/pages/story/repository/story_repository.dart';
import 'package:instagram_clone/utils/locator.dart';
import 'package:meta/meta.dart';

import '../../model/story.dart';

part 'story_event.dart';
part 'story_state.dart';

StoryRepository _storyRepository = locator<StoryRepository>();

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  StoryBloc() : super(StoryInitial()) {
    on<GetStory>((event, emit) async {
      emit(StoryLoading());

      final story = await _storyRepository.getStory();

      if (story is Story) {
        emit(StorySuccess(story: story));
      } else {
        emit(StoryFailure(error: story));
      }
    });

    on<ClearStory>((event, emit) {
      emit(StoryInitial());
    });
  }
}
