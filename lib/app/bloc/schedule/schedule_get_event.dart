part of 'schedule_get_bloc.dart';

abstract class ScheduleGetEvent {}

class ScheduleGetDataEvent extends ScheduleGetEvent {
  final String schedule_id;

  ScheduleGetDataEvent({
    required this.schedule_id,
  });
}

class ScheduleGetSubmittedEvent extends ScheduleGetEvent {
  final String companyId;
  final String scheduleId;
  final String issueDate;
  final String poolId;
  final String counter;
  final String shift;
  final String orderTypeId;
  final String originId;
  final String plantId;
  final String multiProduct;
  final String productId;
  final String employeeId;
  final String primaryStatus;
  final String secondaryStatus;
  final String fleetId;
  final String ujtId;
  final String ujt;

  ScheduleGetSubmittedEvent({
    required this.companyId,
    required this.scheduleId,
    required this.issueDate,
    this.poolId = "1",
    this.counter = "A",
    this.shift = "1",
    required this.orderTypeId,
    required this.originId,
    required this.plantId,
    required this.multiProduct,
    required this.productId,
    required this.employeeId,
    required this.primaryStatus,
    required this.secondaryStatus,
    required this.fleetId,
    required this.ujtId,
    required this.ujt,
  });
}
