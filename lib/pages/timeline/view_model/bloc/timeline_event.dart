part of 'timeline_bloc.dart';

@immutable
abstract class TimelineEvent {}

class GetTimeline extends TimelineEvent {}

class ClearTimeline extends TimelineEvent {}
