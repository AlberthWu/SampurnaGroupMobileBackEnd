part of 'delivery_list_bloc.dart';

abstract class DeliveryListState {
  const DeliveryListState();

  @override
  List<Object> get props => [];
}

class DeliveryListInitial extends DeliveryListState {}

class DeliveryListSuccess extends DeliveryListState {
  List<deliveryListModel> models;
  bool hasReachedMax;
  DateTime? date;
  int page;

  DeliveryListSuccess(
      {this.page = 1,
      this.date,
      required this.models,
      this.hasReachedMax = false});

  DeliveryListSuccess copyWith({
    int page = 1,
    DateTime? date,
    List<deliveryListModel>? models,
    bool hasReachedMax = false,
  }) {
    return DeliveryListSuccess(
      page: page ?? this.page,
      date: date ?? this.date,
      models: models ?? this.models,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
