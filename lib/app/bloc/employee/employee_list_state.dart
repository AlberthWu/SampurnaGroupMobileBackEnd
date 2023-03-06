part of 'employee_list_bloc.dart';

abstract class EmployeeListState {}

class EmployeeListInitial extends EmployeeListState {}

class EmployeeListSuccess extends EmployeeListState {
  List<employeeListModel> models;
  bool hasReachedMax;

  EmployeeListSuccess({required this.models, this.hasReachedMax = false});

  EmployeeListSuccess copyWith(
      {List<employeeListModel>? models, bool hasReachedMax = false}) {
    return EmployeeListSuccess(
      models: models ?? this.models,
      hasReachedMax: hasReachedMax,
    );
  }
}
