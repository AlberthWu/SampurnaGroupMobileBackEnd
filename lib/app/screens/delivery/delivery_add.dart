// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:asm/app/bloc/driver/driver_get_bloc.dart';
import 'package:asm/app/bloc/schedule/schedule_get_bloc.dart';
import 'package:asm/app/bloc/ujt_bloc.dart';
import 'package:asm/app/constant/app_constant.dart';
import 'package:asm/app/constant/color_constant.dart';
import 'package:asm/app/models/autocomplete/autocomplete_model.dart';
import 'package:asm/app/widget/forms/auto_complete_widget.dart';
import 'package:asm/app/widget/forms/text_group_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:path_provider/path_provider.dart';

enum DriverList { Batang, Serep }

class DeliveryAdd extends StatelessWidget {
  final String schedule_id;

  DeliveryAdd({
    Key? key,
    required this.schedule_id,
  }) : super(key: key);

  bool isLoading = false;
  final currencyFormatter = NumberFormat('#,##0', 'ID');

  TextEditingController fleetController = TextEditingController();

  ScheduleGetBloc scheduleBloc = ScheduleGetBloc();
  UjtBloc ujtBloc = UjtBloc();
  DriverGetBloc driverBloc = DriverGetBloc();
  DriverList? driverRadio = DriverList.Batang;

  @override
  Widget build(BuildContext context) {
    scheduleBloc = BlocProvider.of<ScheduleGetBloc>(context);
    ujtBloc = BlocProvider.of<UjtBloc>(context);
    driverBloc = BlocProvider.of<DriverGetBloc>(context);

    scheduleBloc..add(ScheduleGetDataEvent(schedule_id: schedule_id));
    driverBloc..add(DriverGetDataEvent(issue_date: "", plate_no: ""));

    return SafeArea(
      child: OverlayLoaderWithAppIcon(
        isLoading: isLoading,
        overlayBackgroundColor: sgBlack,
        circularProgressColor: sgGold,
        appIcon: Image.asset(
          'assets/logo/loading.gif',
        ),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: sgRed,
            title: Text(
              "Input Surat Jalan",
              style: TextStyle(
                color: sgWhite,
                fontWeight: FontWeight.bold,
                fontFamily: 'Nexa',
              ),
            ),
            iconTheme: IconThemeData(
              color: sgWhite,
            ),
            actions: <Widget>[
              BlocBuilder<ScheduleGetBloc, ScheduleGetState>(
                builder: (context, state) {
                  return IconButton(
                    icon: Icon(
                      Icons.save_outlined,
                      color: sgWhite,
                    ),
                    onPressed: () {},
                  );
                },
              ),
            ],
          ),
          body: Container(
            color: sgWhite,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: BlocBuilder<ScheduleGetBloc, ScheduleGetState>(
              builder: (context, state) {
                if (state is ScheduleGetInitial) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  ScheduleGetSuccessState modelSchedule =
                      state as ScheduleGetSuccessState;

                  ujtBloc
                    ..add(
                      UjtValueEvent(
                        issueDate: modelSchedule.model.schedule_date,
                        originID: modelSchedule.model.origin_id.toString(),
                        plantID: modelSchedule.model.plant_id.toString(),
                        fleetTypeID:
                            modelSchedule.model.fleet_type_id.toString(),
                        productID: modelSchedule.model.product_id.toString(),
                      ),
                    );
                  return ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      sgSizedBoxHeight,
                      SGTextGroupWidget(
                        field: "Grup Perusahaan",
                        value: modelSchedule.model.company_name,
                      ),
                      sgSizedBoxHeight,
                      SGTextGroupWidget(
                        field: "Bisnis Unit",
                        value: modelSchedule.model.bisnis_name,
                      ),
                      sgSizedBoxHeight,
                      SGTextGroupWidget(
                        field: "No Jadwal",
                        value: modelSchedule.model.schedule_no,
                      ),
                      sgSizedBoxHeight,
                      SGTextGroupWidget(
                        field: "Tanggal Jadwal",
                        value: modelSchedule.model.schedule_date,
                      ),
                      sgSizedBoxHeight,
                      SGTextGroupWidget(
                        field: "Jenis Transaksi",
                        value: modelSchedule.model.order_type_name,
                      ),
                      sgSizedBoxHeight,
                      SGTextGroupWidget(
                        field: "Jenis Kendaraan",
                        value: modelSchedule.model.fleet_type_name,
                      ),
                      sgSizedBoxHeight,
                      SGTextGroupWidget(
                        field: "Asal",
                        value: modelSchedule.model.origin_name,
                      ),
                      sgSizedBoxHeight,
                      SGTextGroupWidget(
                        field: "Pelanggan",
                        value: modelSchedule.model.customer_name,
                      ),
                      sgSizedBoxHeight,
                      SGTextGroupWidget(
                        field: "Tujuan",
                        value: modelSchedule.model.plant_name,
                      ),
                      sgSizedBoxHeight,
                      SGTextGroupWidget(
                        field: "Material",
                        value: modelSchedule.model.product_name,
                      ),
                      sgSizedBoxHeight,
                      BlocBuilder<UjtBloc, UjtState>(
                        builder: (context, state) {
                          if (state is UjtInitial) {
                            return SGTextGroupWidget(
                              field: "UJT",
                              value: "0",
                            );
                          } else {
                            UjtSuccessState modelUjt = state as UjtSuccessState;
                            return SGTextGroupWidget(
                              field: "UJT",
                              value:
                                  currencyFormatter.format(modelUjt.model.ujt),
                            );
                          }
                        },
                      ),
                      sgSizedBoxHeight,
                      SGAutoCompleteWidget(
                        controller: fleetController,
                        title: 'Nomor Kendaraan',
                        getData: (keyword) => fleetData(
                          modelSchedule.model.bisnis_id.toString(),
                          modelSchedule.model.fleet_type_id.toString(),
                          keyword,
                        ),
                        setData: (value) => setFleetData(
                            modelSchedule.model.schedule_date, value),
                        id: 0,
                        name: "",
                      ),
                      sgSizedBoxHeight,
                      BlocBuilder<DriverGetBloc, DriverGetState>(
                        builder: (context, state) {
                          if (state is DriverGetInitial) {
                            return Container();
                          } else {
                            DriverGetSuccess modelDriver =
                                state as DriverGetSuccess;

                            return Column(
                              children: [
                                RadioListTile<DriverList>(
                                  title: Text('Supir Batang'),
                                  value: DriverList.Batang,
                                  groupValue: driverRadio,
                                  onChanged: (DriverList? value) {
                                    changeRadio(value);
                                  },
                                  activeColor: sgRed,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: modelDriver.model.primary_driver !=
                                              null
                                          ? Hero(
                                              tag: 'picture',
                                              child: CircleAvatar(
                                                backgroundImage: MemoryImage(
                                                  base64Decode(modelDriver.model
                                                      .primary_driver!.image!),
                                                ),
                                              ),
                                            )
                                          : Hero(
                                              tag: 'picture',
                                              child: CircleAvatar(
                                                backgroundColor: sgWhite,
                                                backgroundImage: AssetImage(
                                                    "assets/images/user.png"),
                                              ),
                                            ),
                                    ),
                                    sgSizedBoxWidth,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          modelDriver.model.primary_driver ==
                                                  null
                                              ? ""
                                              : modelDriver
                                                  .model.primary_driver!.name!,
                                          style: TextStyle(
                                            color: sgBlack,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Nexa',
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          modelDriver.model.primary_driver ==
                                                  null
                                              ? ""
                                              : modelDriver
                                                  .model.primary_driver!.phone!,
                                          style: TextStyle(
                                            color: sgBlack,
                                            fontSize: 14.0,
                                            fontFamily: 'Nexa',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          modelDriver.model.primary_driver ==
                                                  null
                                              ? ""
                                              : modelDriver.model
                                                  .primary_driver!.bank_name!,
                                          style: TextStyle(
                                            color: sgBlack,
                                            fontSize: 14.0,
                                            fontFamily: 'Nexa',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          modelDriver.model.primary_driver ==
                                                  null
                                              ? ""
                                              : modelDriver.model
                                                  .primary_driver!.bank_no!,
                                          style: TextStyle(
                                            color: sgBlack,
                                            fontSize: 14.0,
                                            fontFamily: 'Nexa',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          modelDriver.model.primary_driver ==
                                                  null
                                              ? ""
                                              : modelDriver
                                                  .model
                                                  .primary_driver!
                                                  .license_type!,
                                          style: TextStyle(
                                            color: sgBlack,
                                            fontSize: 14.0,
                                            fontFamily: 'Nexa',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          modelDriver.model.primary_driver ==
                                                  null
                                              ? ""
                                              : modelDriver.model
                                                  .primary_driver!.license_no!,
                                          style: TextStyle(
                                            color: sgBlack,
                                            fontSize: 14.0,
                                            fontFamily: 'Nexa',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          modelDriver.model.primary_driver ==
                                                  null
                                              ? ""
                                              : modelDriver
                                                  .model
                                                  .primary_driver!
                                                  .license_exp_date!,
                                          style: TextStyle(
                                            color: sgBlack,
                                            fontSize: 14.0,
                                            fontFamily: 'Nexa',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                RadioListTile<DriverList>(
                                  title: Text('Supir Serep'),
                                  value: DriverList.Serep,
                                  groupValue: driverRadio,
                                  onChanged: (DriverList? value) {
                                    changeRadio(value);
                                  },
                                  activeColor: sgRed,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: modelDriver
                                                  .model.secondary_driver !=
                                              null
                                          ? Hero(
                                              tag: 'picture',
                                              child: CircleAvatar(
                                                backgroundImage: MemoryImage(
                                                  base64Decode(modelDriver
                                                      .model
                                                      .secondary_driver!
                                                      .image!),
                                                ),
                                              ),
                                            )
                                          : Hero(
                                              tag: 'picture',
                                              child: CircleAvatar(
                                                backgroundColor: sgWhite,
                                                backgroundImage: AssetImage(
                                                    "assets/images/user.png"),
                                              ),
                                            ),
                                    ),
                                    sgSizedBoxWidth,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        sgSizedBoxHeight,
                                        Text(
                                          modelDriver.model.secondary_driver ==
                                                  null
                                              ? ""
                                              : modelDriver.model
                                                  .secondary_driver!.name!,
                                          style: TextStyle(
                                            color: sgBlack,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Nexa',
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          modelDriver.model.secondary_driver ==
                                                  null
                                              ? ""
                                              : modelDriver.model
                                                  .secondary_driver!.phone!,
                                          style: TextStyle(
                                            color: sgBlack,
                                            fontSize: 14.0,
                                            fontFamily: 'Nexa',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          modelDriver.model.secondary_driver ==
                                                  null
                                              ? ""
                                              : modelDriver.model
                                                  .secondary_driver!.bank_name!,
                                          style: TextStyle(
                                            color: sgBlack,
                                            fontSize: 14.0,
                                            fontFamily: 'Nexa',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          modelDriver.model.secondary_driver ==
                                                  null
                                              ? ""
                                              : modelDriver.model
                                                  .secondary_driver!.bank_no!,
                                          style: TextStyle(
                                            color: sgBlack,
                                            fontSize: 14.0,
                                            fontFamily: 'Nexa',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          modelDriver.model.secondary_driver ==
                                                  null
                                              ? ""
                                              : modelDriver
                                                  .model
                                                  .secondary_driver!
                                                  .license_type!,
                                          style: TextStyle(
                                            color: sgBlack,
                                            fontSize: 14.0,
                                            fontFamily: 'Nexa',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          modelDriver.model.secondary_driver ==
                                                  null
                                              ? ""
                                              : modelDriver
                                                  .model
                                                  .secondary_driver!
                                                  .license_no!,
                                          style: TextStyle(
                                            color: sgBlack,
                                            fontSize: 14.0,
                                            fontFamily: 'Nexa',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          modelDriver.model.secondary_driver ==
                                                  null
                                              ? ""
                                              : modelDriver
                                                  .model
                                                  .secondary_driver!
                                                  .license_exp_date!,
                                          style: TextStyle(
                                            color: sgBlack,
                                            fontSize: 14.0,
                                            fontFamily: 'Nexa',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      sgSizedBoxHeight,
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  changeRadio(value) {
    print(value);
    driverRadio = value;
  }

  Future<List<autocompleteListModel>> fleetData(
      String business_id, String fleet_type_id, String keyword) async {
    List<autocompleteListModel> _models = [];

    _models = await autocompleteListModel.getAPIFleetAutoComplete(
        business_id, fleet_type_id, keyword);

    return _models;
  }

  Future<void> setFleetData(
      String issue_date, autocompleteListModel data) async {
    driverBloc
      ..add(
        DriverGetDataEvent(issue_date: issue_date, plate_no: data.getName()),
      );
  }
}
