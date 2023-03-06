import 'package:asm/app/models/orders/driver.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'driver_get_event.dart';
part 'driver_get_state.dart';

class DriverGetBloc extends Bloc<DriverGetEvent, DriverGetState> {
  DriverGetBloc() : super(DriverGetInitial()) {
    on<DriverGetDataEvent>((event, emit) async {
      driverGetModel model;

      emit(DriverGetInitial());

      model =
          await driverGetModel.getAPIDriver(event.issue_date, event.plate_no);

      emit(DriverGetSuccess(model: model));
    });
  }
}
