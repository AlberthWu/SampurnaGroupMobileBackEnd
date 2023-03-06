part of 'delivery_today_bloc.dart';

abstract class DeliveryTodayState {}

class DeliveryTodayInitial extends DeliveryTodayState {}

class DeliveryTodaySuccess extends DeliveryTodayState {
  List<deliveryListModel> models;
  bool hasReachedMax;
  DateTime? date;
  int page;

  DeliveryTodaySuccess(
      {this.page = 1,
      this.date,
      required this.models,
      this.hasReachedMax = false});

  DeliveryTodaySuccess copyWith({
    int page = 1,
    DateTime? date,
    List<deliveryListModel>? models,
    bool hasReachedMax = false,
  }) {
    return DeliveryTodaySuccess(
      page: page,
      date: date ?? this.date,
      models: models ?? this.models,
      hasReachedMax: hasReachedMax,
    );
  }
}
