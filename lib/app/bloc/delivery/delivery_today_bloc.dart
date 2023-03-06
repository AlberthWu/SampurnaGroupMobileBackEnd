import 'package:asm/app/models/orders/surat_jalan/list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'delivery_today_event.dart';
part 'delivery_today_state.dart';

class DeliveryTodayBloc extends Bloc<DeliveryTodayEvent, DeliveryTodayState> {
  DeliveryTodayBloc() : super(DeliveryTodayInitial()) {
    on<GetDeliveryTodayEvent>((event, emit) async {
      List<deliveryListModel> models;

      String date = DateFormat('yyyy-MM-dd').format(event.date);

      if (event.reload) {
        emit(DeliveryTodayInitial());
      }

      if (state is DeliveryTodayInitial) {
        models = await deliveryListModel.connectToAPIToday(date, 1, 10);

        emit(
          DeliveryTodaySuccess(
            date: event.date,
            models: models,
            hasReachedMax: models.length < 10 ? true : false,
          ),
        );
      } else {
        DeliveryTodaySuccess loaded = state as DeliveryTodaySuccess;
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
          models = await deliveryListModel.connectToAPIToday(date, page, 10);

          if (loaded.models.length > 0) {
            emit(
              models.isEmpty
                  ? loaded.copyWith(hasReachedMax: true)
                  : DeliveryTodaySuccess(
                      page: page,
                      date: event.date,
                      models: loaded.models + models,
                      hasReachedMax: false,
                    ),
            );
          } else {
            models = await deliveryListModel.connectToAPIToday(date, 1, 10);

            emit(
              DeliveryTodaySuccess(
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
