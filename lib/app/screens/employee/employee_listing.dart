import 'package:asm/app/bloc/employee_list_bloc.dart';
import 'package:asm/app/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:asm/app/views/cards/employee_card_widget.dart';

class EmployeeList extends StatelessWidget {
  ScrollController controller = ScrollController();
  EmployeeListBloc bloc = EmployeeListBloc();

  void onScroll() {
    double maxScroll = controller.position.maxScrollExtent;
    double currentScroll = controller.position.pixels;

    if (currentScroll == maxScroll) bloc.add(GetEmployeeEvent(keyword: ""));
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<EmployeeListBloc>(context);
    controller.addListener(onScroll);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: sgRed,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Employee',
              style: TextStyle(
                color: sgWhite,
                fontWeight: FontWeight.bold,
                fontSize: 24,
                fontFamily: 'Nexa',
              ),
            ),
            Icon(
              Icons.edit_note_outlined,
              color: sgRed,
              size: 30.0,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(
            'employee_create',
            params: {
              'id': '0',
            },
          );
        },
        backgroundColor: sgRed,
        child: Icon(Icons.add),
      ),
      body: BlocBuilder<EmployeeListBloc, EmployeeListState>(
        builder: (context, state) {
          if (state is EmployeeListInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            EmployeeListSuccess modelSuccess = state as EmployeeListSuccess;

            return Container(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                controller: controller,
                itemBuilder: (context, index) =>
                    (index < modelSuccess.models.length)
                        ? GestureDetector(
                            onTap: () {
                              context.goNamed(
                                'employee_create',
                                params: {
                                  'id':
                                      modelSuccess.models[index].id.toString(),
                                },
                              );
                            },
                            child: EmployeeCardWidget(
                                model: modelSuccess.models[index]),
                          )
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
      ),
    );
  }
}
