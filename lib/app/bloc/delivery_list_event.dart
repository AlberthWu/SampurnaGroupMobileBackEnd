part of 'delivery_list_bloc.dart';

abstract class DeliveryListEvent {
  const DeliveryListEvent();

  @override
  List<Object> get props => [];
}

class GetDeliveryEvent extends DeliveryListEvent {
  final bool reload;
  final DateTime date;

  const GetDeliveryEvent({this.reload = false, required this.date});

  @override
  List<Object> get props => [date];
}
