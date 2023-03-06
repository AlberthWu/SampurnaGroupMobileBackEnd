part of 'schedule_list_bloc.dart';

abstract class ScheduleListEvent {}

class GetScheduleEvent extends ScheduleListEvent {
  final bool reload;
  final DateTime date;

  GetScheduleEvent({this.reload = false, required this.date});
}
