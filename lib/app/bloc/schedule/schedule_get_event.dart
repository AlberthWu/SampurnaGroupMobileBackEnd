part of 'schedule_get_bloc.dart';

abstract class ScheduleGetEvent {}

class ScheduleGetDataEvent extends ScheduleGetEvent {
  final String schedule_id;

  ScheduleGetDataEvent({
    required this.schedule_id,
  });
}

class ScheduleGetFleetEvent extends ScheduleGetEvent {
  final scheduleGetModel model;
  final autocompleteListModel plate;

  ScheduleGetFleetEvent({
    required this.model,
    required this.plate,
  });
}

class ScheduleGetStatusEvent extends ScheduleGetEvent {
  final scheduleGetModel model;
  int selected;
  int employee_id;

  ScheduleGetStatusEvent({
    required this.model,
    required this.selected,
    required this.employee_id,
  });
}

class ScheduleGetSubmittedEvent extends ScheduleGetEvent {
  final scheduleGetModel model;

  ScheduleGetSubmittedEvent({
    required this.model,
  });
}
