part of 'delivery_create_bloc.dart';

abstract class DeliveryCreateEvent {}

class DeliveryCreateScheduleEvent extends DeliveryCreateEvent {
  final String schedule_id;

  DeliveryCreateScheduleEvent({
    this.schedule_id = "0",
  });
}

class DeliveryCreateChangeEvent extends DeliveryCreateEvent {
  final String primaryStatus;
  final String secondaryStatus;
  final String fleetId;
  final String employeeId;
  final String ujtId;
  final String ujt;

  DeliveryCreateChangeEvent({
    required this.primaryStatus,
    required this.secondaryStatus,
    required this.fleetId,
    required this.employeeId,
    required this.ujtId,
    required this.ujt,
  });
}

class DeliveryCreateSubmittedEvent extends DeliveryCreateEvent {
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

  DeliveryCreateSubmittedEvent({
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
