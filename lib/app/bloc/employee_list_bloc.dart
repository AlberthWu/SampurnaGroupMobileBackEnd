import 'package:asm/app/models/employee/list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employee_list_event.dart';
part 'employee_list_state.dart';

class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  EmployeeListBloc() : super(EmployeeListInitial()) {
    on<GetEmployeeEvent>((event, emit) async {
      List<employeeListModel> models;

      if (state is EmployeeListInitial) {
        models = await employeeListModel.connectToAPI(1, 20, event.keyword);

        emit(
          EmployeeListSuccess(
            models: models,
            hasReachedMax: false,
          ),
        );
      } else {
        EmployeeListSuccess loaded = state as EmployeeListSuccess;
        int page = (loaded.models.length ~/ 20) + 1;

        models = await employeeListModel.connectToAPI(page, 20, event.keyword);
        if (loaded.models.length > 0) {
          emit(
            models.isEmpty
                ? loaded.copyWith(hasReachedMax: true)
                : EmployeeListSuccess(
                    models: loaded.models + models,
                    hasReachedMax: false,
                  ),
          );
        } else {
          models = await employeeListModel.connectToAPI(1, 20, event.keyword);

          emit(
            EmployeeListSuccess(
              models: models,
              hasReachedMax: false,
            ),
          );
        }
      }
    });
  }
}
