part of 'employee_list_bloc.dart';

abstract class EmployeeListEvent {
  const EmployeeListEvent();

  @override
  List<Object> get props => [];
}

class GetEmployeeEvent extends EmployeeListEvent {
  final String keyword;

  const GetEmployeeEvent({required this.keyword});

  @override
  List<Object> get props => [keyword];
}
