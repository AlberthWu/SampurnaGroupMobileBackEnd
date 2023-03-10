part of 'schedule_get_bloc.dart';

abstract class ScheduleGetState {}

class ScheduleGetInitial extends ScheduleGetState {}

class ScheduleGetLoadingState extends ScheduleGetState {}

class ScheduleGetInvalidState extends ScheduleGetState {}

class ScheduleGetValidState extends ScheduleGetState {}

class ScheduleGetErrorState extends ScheduleGetState {
  final String errorMessage;

  ScheduleGetErrorState({required this.errorMessage});
}

class ScheduleGetSuccessState extends ScheduleGetState {
  final scheduleGetModel model;

  ScheduleGetSuccessState({required this.model});
}

class ScheduleGetDeliverySuccessState extends ScheduleGetState {
  final deliveryGetModel model;
  final String message;

  ScheduleGetDeliverySuccessState({required this.model, required this.message});
}
