part of 'delivery_running_bloc.dart';

abstract class DeliveryRunningState {}

class DeliveryRunningInitial extends DeliveryRunningState {}

class DeliveryRunningSuccess extends DeliveryRunningState {
  List<deliveryListModel> models;
  bool hasReachedMax;
  DateTime? date;
  int page;

  DeliveryRunningSuccess(
      {this.page = 1,
      this.date,
      required this.models,
      this.hasReachedMax = false});

  DeliveryRunningSuccess copyWith({
    int page = 1,
    DateTime? date,
    List<deliveryListModel>? models,
    bool hasReachedMax = false,
  }) {
    return DeliveryRunningSuccess(
      page: page,
      date: date ?? this.date,
      models: models ?? this.models,
      hasReachedMax: hasReachedMax,
    );
  }
}
