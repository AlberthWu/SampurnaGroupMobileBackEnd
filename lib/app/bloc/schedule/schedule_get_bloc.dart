import 'package:asm/app/models/autocomplete/autocomplete_model.dart';
import 'package:asm/app/models/orders/schedule/get.dart';
import 'package:asm/app/models/orders/ujt.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'schedule_get_event.dart';
part 'schedule_get_state.dart';

class ScheduleGetBloc extends Bloc<ScheduleGetEvent, ScheduleGetState> {
  ScheduleGetBloc() : super(ScheduleGetInitial()) {
    on<ScheduleGetDataEvent>((event, emit) async {
      scheduleGetModel model;
      ujtGetModel ujtModel;

      emit(ScheduleGetInitial());

      model = await scheduleGetModel.getAPISchedule(event.schedule_id);

      ujtModel = await ujtGetModel.getAPIUjt(
        model.schedule_date,
        model.plant_id.toString(),
        model.origin_id.toString(),
        model.fleet_type_id.toString(),
        model.product_id.toString(),
      );

      model.ujt_id = ujtModel.id;
      model.ujt = ujtModel.ujt;

      emit(ScheduleGetSuccessState(model: model));
    });
    on<ScheduleGetFleetEvent>((event, emit) async {
      event.model.fleet_id = event.plate.id;
      event.model.plate_no = event.plate.name;

      emit(ScheduleGetSuccessState(model: event.model));
    });
    on<ScheduleGetStatusEvent>((event, emit) async {
      if (event.selected == 0) {
        event.model.primary_status = 1;
        event.model.secondary_status = 0;
      } else {
        event.model.primary_status = 0;
        event.model.secondary_status = 1;
      }

      event.model.employee_id = event.employee_id;

      emit(ScheduleGetSuccessState(model: event.model));
    });
  }
}
