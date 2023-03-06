import 'package:asm/app/models/orders/ujt.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ujt_event.dart';
part 'ujt_state.dart';

class UjtBloc extends Bloc<UjtEvent, UjtState> {
  UjtBloc() : super(UjtInitial()) {
    on<UjtValueEvent>((event, emit) async {
      ujtGetModel model;

      emit(UjtInitial());

      model = await ujtGetModel.getAPIUjt(event.issueDate, event.plantID,
          event.originID, event.fleetTypeID, event.productID);

      emit(UjtSuccessState(model: model));
    });
  }
}
