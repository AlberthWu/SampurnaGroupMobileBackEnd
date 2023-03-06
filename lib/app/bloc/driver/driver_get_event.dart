part of 'driver_get_bloc.dart';

abstract class DriverGetEvent {}

class DriverGetDataEvent extends DriverGetEvent {
  final String issue_date;
  final String plate_no;

  DriverGetDataEvent({
    required this.issue_date,
    required this.plate_no,
  });
}
