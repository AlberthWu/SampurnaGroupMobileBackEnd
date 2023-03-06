part of 'driver_get_bloc.dart';

abstract class DriverGetState {}

class DriverGetInitial extends DriverGetState {}

class DriverGetSuccess extends DriverGetState {
  final driverGetModel model;

  DriverGetSuccess({required this.model});
}
