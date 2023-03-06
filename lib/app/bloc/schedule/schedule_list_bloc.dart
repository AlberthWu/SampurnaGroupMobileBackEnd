import 'package:asm/app/models/orders/schedule/list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'schedule_list_event.dart';
part 'schedule_list_state.dart';

class ScheduleListBloc extends Bloc<ScheduleListEvent, ScheduleListState> {
  ScheduleListBloc() : super(ScheduleListInitial()) {
    on<GetScheduleEvent>((event, emit) async {
      List<scheduleListModel> models;

      String date = DateFormat('yyyy-MM-dd').format(event.date);

      if (event.reload) {
        emit(ScheduleListInitial());
      }

      if (state is ScheduleListInitial) {
        models = await scheduleListModel.connectToAPI(date, 1, 10);

        emit(
          ScheduleListSuccess(
            date: event.date,
            models: models,
            hasReachedMax: models.length < 10 ? true : false,
          ),
        );
      } else {
        ScheduleListSuccess loaded = state as ScheduleListSuccess;
        int page = (loaded.models.length ~/ 10) + 1;

        if (loaded.page == page) {
          emit(
            loaded.copyWith(
              page: loaded.page,
              date: event.date,
              hasReachedMax: true,
            ),
          );
        } else {
          models = await scheduleListModel.connectToAPI(date, page, 10);

          if (loaded.models.length > 0) {
            emit(
              models.isEmpty
                  ? loaded.copyWith(hasReachedMax: true)
                  : ScheduleListSuccess(
                      page: page,
                      date: event.date,
                      models: loaded.models + models,
                      hasReachedMax: false,
                    ),
            );
          } else {
            models = await scheduleListModel.connectToAPI(date, 1, 10);

            emit(
              ScheduleListSuccess(
                date: event.date,
                models: models,
                hasReachedMax: models.length < 10 ? true : false,
              ),
            );
          }
        }
      }
    });
  }
}
