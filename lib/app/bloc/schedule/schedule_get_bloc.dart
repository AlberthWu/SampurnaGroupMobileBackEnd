import 'package:asm/app/models/api_response.dart';
import 'package:asm/app/models/autocomplete/autocomplete_model.dart';
import 'package:asm/app/models/orders/schedule/get.dart';
import 'package:asm/app/models/orders/surat_jalan/get.dart';
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
    on<ScheduleGetFleetEvent>((event, emit) {
      event.model.fleet_id = event.plate.id;
      event.model.plate_no = event.plate.name;

      emit(ScheduleGetSuccessState(model: event.model));
    });
    on<ScheduleGetStatusEvent>((event, emit) {
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
    on<ScheduleGetSubmittedEvent>((event, emit) async {
      var form = new Map<String, String>();

      form['company_id'] = event.model.company_id.toString();
      form['schedule_id'] = event.model.id.toString();
      form['issue_date'] = event.model.schedule_date;
      form['pool_id'] = event.model.pool_id.toString();
      form['counter'] = event.model.counter.toString();
      form['shift'] = event.model.shift;
      form['order_type_id'] = event.model.order_type_id.toString();
      form['origin_id'] = event.model.origin_id.toString();
      form['plant_id'] = event.model.plant_id.toString();
      form['multi_product'] = event.model.multi_product.toString();
      form['product_id'] = event.model.product_id.toString();
      form['fleet_id'] = event.model.fleet_id.toString();
      form['employee_id'] = event.model.employee_id.toString();
      form['ujt_id'] = event.model.ujt_id.toString();
      form['ujt'] = event.model.ujt.toString();
      form['primary_status'] = event.model.primary_status.toString();
      form['secondary_status'] = event.model.secondary_status.toString();

      APIResponse<deliveryGetModel> result =
          await deliveryGetModel.postDelivery(form);

      if (result.status) {
        emit(ScheduleGetInvalidState());

        emit(ScheduleGetErrorState(
          errorMessage: result.message,
        ));
      } else {
        emit(ScheduleGetValidState());

        emit(ScheduleGetDeliverySuccessState(
          model: result.data,
          message: result.message,
        ));
      }
    });
  }
}
