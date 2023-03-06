part of 'delivery_running_bloc.dart';

abstract class DeliveryRunningEvent {}

class GetDeliveryRunningEvent extends DeliveryRunningEvent {
  final bool reload;
  final DateTime date;

  GetDeliveryRunningEvent({this.reload = false, required this.date});
}
