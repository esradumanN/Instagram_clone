part of 'story_bloc.dart';

@immutable
abstract class StoryState {}

class StoryInitial extends StoryState {}

class StoryLoading extends StoryState {}

class StorySuccess extends StoryState {
  final Story story;

  StorySuccess({required this.story});
}

class StoryFailure extends StoryState {
  final String error;

  StoryFailure({
    required this.error,
  });
}
