import 'package:flutter_bloc/flutter_bloc.dart';

part 'delivery_create_event.dart';
part 'delivery_create_state.dart';

class DeliveryCreateBloc
    extends Bloc<DeliveryCreateEvent, DeliveryCreateState> {
  DeliveryCreateBloc() : super(DeliveryCreateInitial()) {
    on<DeliveryCreateEvent>((event, emit) {});
  }
}
