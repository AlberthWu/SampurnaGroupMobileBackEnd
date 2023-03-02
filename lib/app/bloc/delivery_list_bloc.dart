import 'package:asm/app/models/orders/surat_jalan/list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'delivery_list_event.dart';
part 'delivery_list_state.dart';

class DeliveryListBloc extends Bloc<DeliveryListEvent, DeliveryListState> {
  DeliveryListBloc() : super(DeliveryListInitial()) {
    on<GetDeliveryEvent>((event, emit) async {
      List<deliveryListModel> models;

      String date = DateFormat('yyyy-MM-dd').format(event.date);

      if (event.reload) {
        emit(DeliveryListInitial());
      }

      if (state is DeliveryListInitial) {
        models = await deliveryListModel.connectToAPI(date, 1, 10);

        emit(
          DeliveryListSuccess(
            date: event.date,
            models: models,
            hasReachedMax: false,
          ),
        );
      } else {
        DeliveryListSuccess loaded = state as DeliveryListSuccess;
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
          models = await deliveryListModel.connectToAPI(date, page, 10);

          if (loaded.models.length > 0) {
            emit(
              models.isEmpty
                  ? loaded.copyWith(hasReachedMax: true)
                  : DeliveryListSuccess(
                      page: page,
                      date: event.date,
                      models: loaded.models + models,
                      hasReachedMax: false,
                    ),
            );
          } else {
            models = await deliveryListModel.connectToAPI(date, 1, 10);

            emit(
              DeliveryListSuccess(
                date: event.date,
                models: models,
                hasReachedMax: false,
              ),
            );
          }
        }
      }
    });
  }
}
