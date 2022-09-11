part of 'timeline_bloc.dart';

@immutable
abstract class TimelineState {}

class TimelineInitial extends TimelineState {}

class TimelineLoading extends TimelineState {}

class TimelineSuccess extends TimelineState {
  final Timeline timeline;

  TimelineSuccess({required this.timeline});
}

class TimelineFailure extends TimelineState {
  final String error;

  TimelineFailure({
    required this.error,
  });
}
