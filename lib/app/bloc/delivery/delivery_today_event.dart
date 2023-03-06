part of 'delivery_today_bloc.dart';

abstract class DeliveryTodayEvent {}

class GetDeliveryTodayEvent extends DeliveryTodayEvent {
  final bool reload;
  final DateTime date;

  GetDeliveryTodayEvent({this.reload = false, required this.date});
}
