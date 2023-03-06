part of 'ujt_bloc.dart';

abstract class UjtState {}

class UjtInitial extends UjtState {}

class UjtSuccessState extends UjtState {
  final ujtGetModel model;

  UjtSuccessState({required this.model});
}
