part of 'story_bloc.dart';

@immutable
abstract class StoryEvent {}

class GetStory extends StoryEvent {}

class ClearStory extends StoryEvent {}
