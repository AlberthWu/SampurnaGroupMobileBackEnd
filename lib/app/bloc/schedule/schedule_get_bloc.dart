import 'package:asm/app/models/orders/schedule/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'schedule_get_event.dart';
part 'schedule_get_state.dart';

class ScheduleGetBloc extends Bloc<ScheduleGetEvent, ScheduleGetState> {
  ScheduleGetBloc() : super(ScheduleGetInitial()) {
    on<ScheduleGetDataEvent>((event, emit) async {
      scheduleGetModel model;

      emit(ScheduleGetInitial());

      model = await scheduleGetModel.getAPISchedule(event.schedule_id);

      emit(ScheduleGetSuccessState(model: model));
    });
  }
}
