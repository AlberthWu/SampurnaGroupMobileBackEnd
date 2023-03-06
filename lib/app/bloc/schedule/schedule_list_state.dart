part of 'schedule_list_bloc.dart';

abstract class ScheduleListState {}

class ScheduleListInitial extends ScheduleListState {}

class ScheduleListSuccess extends ScheduleListState {
  List<scheduleListModel> models;
  bool hasReachedMax;
  DateTime? date;
  int page;

  ScheduleListSuccess(
      {this.page = 1,
      this.date,
      required this.models,
      this.hasReachedMax = false});

  ScheduleListSuccess copyWith({
    int page = 1,
    DateTime? date,
    List<scheduleListModel>? models,
    bool hasReachedMax = false,
  }) {
    return ScheduleListSuccess(
      page: page,
      date: date ?? this.date,
      models: models ?? this.models,
      hasReachedMax: hasReachedMax,
    );
  }
}
