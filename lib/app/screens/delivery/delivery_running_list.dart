import 'package:asm/app/bloc/delivery_list_bloc.dart';
import 'package:asm/app/views/cards/delivery_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryRunningList extends StatelessWidget {
  final DateTime date;

  DeliveryRunningList({
    Key? key,
    required this.date,
  }) : super(key: key);

  ScrollController controller = ScrollController();
  DeliveryListBloc bloc = DeliveryListBloc();

  void onScroll() {
    double maxScroll = controller.position.maxScrollExtent;
    double currentScroll = controller.position.pixels;

    if (currentScroll == maxScroll) bloc.add(GetDeliveryEvent(date: date));
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<DeliveryListBloc>(context);
    controller.addListener(onScroll);

    return BlocBuilder<DeliveryListBloc, DeliveryListState>(
      builder: (context, state) {
        if (state is DeliveryListInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          DeliveryListSuccess modelSuccess = state as DeliveryListSuccess;

          return Container(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              controller: controller,
              itemBuilder: (context, index) =>
                  (index < modelSuccess.models.length)
                      ? DeliveryCardWidget(model: modelSuccess.models[index])
                      : Container(
                          child: const Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
              itemCount: modelSuccess.hasReachedMax
                  ? modelSuccess.models.length
                  : modelSuccess.models.length + 1,
            ),
          );
        }
      },
    );
  }
}
