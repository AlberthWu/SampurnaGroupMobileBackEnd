part of 'employee_list_bloc.dart';

abstract class EmployeeListEvent {}

class GetEmployeeEvent extends EmployeeListEvent {
  final String keyword;

  GetEmployeeEvent({required this.keyword});
}
