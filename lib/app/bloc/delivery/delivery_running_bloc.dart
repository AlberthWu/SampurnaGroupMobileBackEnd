import 'package:asm/app/models/orders/surat_jalan/list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'delivery_running_event.dart';
part 'delivery_running_state.dart';

class DeliveryRunningBloc
    extends Bloc<DeliveryRunningEvent, DeliveryRunningState> {
  DeliveryRunningBloc() : super(DeliveryRunningInitial()) {
    on<GetDeliveryRunningEvent>((event, emit) async {
      List<deliveryListModel> models;

      String date = DateFormat('yyyy-MM-dd').format(event.date);

      if (event.reload) {
        emit(DeliveryRunningInitial());
      }

      if (state is DeliveryRunningInitial) {
        models = await deliveryListModel.connectToAPIRunning(date, 1, 10);

        emit(
          DeliveryRunningSuccess(
            date: event.date,
            models: models,
            hasReachedMax: models.length < 10 ? true : false,
          ),
        );
      } else {
        DeliveryRunningSuccess loaded = state as DeliveryRunningSuccess;
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
          models = await deliveryListModel.connectToAPIRunning(date, page, 10);

          if (loaded.models.length > 0) {
            emit(
              models.isEmpty
                  ? loaded.copyWith(hasReachedMax: true)
                  : DeliveryRunningSuccess(
                      page: page,
                      date: event.date,
                      models: loaded.models + models,
                      hasReachedMax: false,
                    ),
            );
          } else {
            models = await deliveryListModel.connectToAPIRunning(date, 1, 10);

            emit(
              DeliveryRunningSuccess(
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
