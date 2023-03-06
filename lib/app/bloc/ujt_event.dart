part of 'ujt_bloc.dart';

abstract class UjtEvent {}

class UjtValueEvent extends UjtEvent {
  final String issueDate;
  final String plantID;
  final String originID;
  final String fleetTypeID;
  final String productID;

  UjtValueEvent({
    required this.issueDate,
    required this.plantID,
    required this.originID,
    required this.fleetTypeID,
    required this.productID,
  });
}
