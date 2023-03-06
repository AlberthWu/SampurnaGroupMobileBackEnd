import 'dart:convert';

import 'package:asm/app/constant/color_constant.dart';
import 'package:asm/app/constant/app_constant.dart';
import 'package:asm/app/models/api_response.dart';
import 'package:asm/app/models/autocomplete/autocomplete_model.dart';
import 'package:asm/app/models/orders/driver.dart';
import 'package:asm/app/models/orders/schedule/get.dart';
import 'package:asm/app/models/orders/ujt.dart';
import 'package:asm/app/service/autocomplete_service.dart';
import 'package:asm/app/service/driver.dart';
import 'package:asm/app/service/orders/delivery.dart';
import 'package:asm/app/service/orders/schedule.dart';
import 'package:asm/app/service/orders/ujt.dart';
import 'package:asm/app/widget/forms/auto_complete_widget.dart';
import 'package:asm/app/widget/forms/text_group_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

enum DriverList { Batang, Serep }

class DeliveryCreate extends StatefulWidget {
  final int schedule_id;

  const DeliveryCreate({
    Key? key,
    this.schedule_id = 0,
  }) : super(key: key);

  @override
  State<DeliveryCreate> createState() => _DeliveryCreateState();
}

class _DeliveryCreateState extends State<DeliveryCreate> {
  deliveryService get serviceDelivery => GetIt.I<deliveryService>();
  scheduleService get serviceSchedule => GetIt.I<scheduleService>();
  autoCompleteService get serviceAutoComplete => GetIt.I<autoCompleteService>();
  final currencyFormatter = NumberFormat('#,##0', 'ID');

  ujtService get serviceUJT => GetIt.I<ujtService>();
  late ujtGetModel _modelUJT = new ujtGetModel();

  driverService get serviceDriver => GetIt.I<driverService>();
  late driverGetModel _modelDriver = new driverGetModel();

  Rx<String> dbImageBatang = ''.obs;
  Rx<String> dbImageSerep = ''.obs;

  late APIResponse<List<autocompleteListModel>> _apiResponseAuto;

  late scheduleGetModel _model = new scheduleGetModel();
  late String errorMessage = "";
  bool _isLoading = false;

  TextEditingController _fleetController = TextEditingController();
  DriverList? _driver = DriverList.Batang;

  @override
  void initState() {
    if (widget.schedule_id > 0) {
      _getDataSchedule();
    }

    super.initState();
  }

  _getDataSchedule() async {
    setState(() {
      _isLoading = true;
    });

    await serviceSchedule.GetSchedule(widget.schedule_id).then(
      (response) {
        if (response.status) {
          errorMessage = response.message;
          _model = scheduleGetModel();

          setState(() {
            _isLoading = false;
          });
        } else {
          _model = response.data;
          _getUJT();
        }
      },
    );
  }

  _getUJT() async {
    setState(() {
      _isLoading = true;
    });

    await serviceUJT.GetUjt(_model.schedule_date, _model.plant_id,
            _model.origin_id, _model.fleet_type_id, _model.product_id)
        .then(
      (response) {
        if (response.status) {
          errorMessage = response.message;
          _modelUJT = ujtGetModel();
        } else {
          _modelUJT = response.data;
        }
      },
    );

    setState(() {
      _isLoading = false;
    });
  }

  _getDriver(value) async {
    autocompleteListModel data = value;

    var plateNo = data.getName();

    await serviceDriver.GetDriver(_model.schedule_date, plateNo).then(
      (response) {
        if (response.status) {
          errorMessage = response.message;
          _modelDriver = new driverGetModel();
        } else {
          _modelDriver = response.data;

          if (_modelDriver.primary_driver!.image != null) {
            dbImageBatang.value = _modelDriver.primary_driver!.image!;
          }

          if (_modelDriver.secondary_driver!.image != null) {
            dbImageSerep.value = _modelDriver.secondary_driver!.image!;
          }
        }
      },
    );

    setState(() {});
  }

  _save() async {
    setState(() {
      _isLoading = true;
    });
    var form = new Map<String, String>();

    form['company_id'] = _model.company_id.toString();
    form['schedule_id'] = _model.id.toString();
    form['issue_date'] = _model.schedule_date;
    form['pool_id'] = "1";
    form['counter'] = "A";
    form['shift'] = "1";
    form['order_type_id'] = _model.order_type_id.toString();
    form['origin_id'] = _model.origin_id.toString();
    form['plant_id'] = _model.plant_id.toString();
    form['multi_product'] = _model.multi_product.toString();
    form['product_id'] = _model.product_id.toString();
    form['fleet_id'] = _fleetController.text;
    form['employee_id'] = _driver == DriverList.Batang
        ? _modelDriver.primary_driver!.id.toString()
        : _modelDriver.secondary_driver == null
            ? "0"
            : _modelDriver.secondary_driver!.id.toString();
    form['ujt_id'] = _modelUJT.id.toString();
    form['ujt'] = _modelUJT.ujt.toString();
    form['primary_status'] = _driver == "Batang" ? "1" : "0";
    form['secondary_status'] = _driver == "Serep" ? "1" : "0";

    final result = await serviceDelivery.PostDelivery(form);

    final title = 'Information';
    final text = result.message;
    final data = result.data;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(text),
        actions: <Widget>[
          ElevatedButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    ).then((res) {
      print(res);
      if (!result.status) {
        context.goNamed(
          'delivery_modify',
          params: {
            'id': data.id.toString(),
          },
        );
      }
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: OverlayLoaderWithAppIcon(
        isLoading: _isLoading,
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
              IconButton(
                icon: Icon(
                  Icons.save_outlined,
                  color: sgWhite,
                ),
                onPressed: () => _save(),
              ),
            ],
          ),
          body: Container(
            color: sgWhite,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                sgSizedBoxHeight,
                SGTextGroupWidget(
                  field: "Grup Perusahaan",
                  value: _model.company_name,
                ),
                sgSizedBoxHeight,
                SGTextGroupWidget(
                  field: "Bisnis Unit",
                  value: _model.bisnis_name,
                ),
                sgSizedBoxHeight,
                SGTextGroupWidget(
                  field: "Jenis Transaksi",
                  value: _model.order_type_name,
                ),
                sgSizedBoxHeight,
                SGTextGroupWidget(
                  field: "Jenis Kendaraan",
                  value: _model.fleet_type_name,
                ),
                sgSizedBoxHeight,
                SGTextGroupWidget(
                  field: "Asal",
                  value: _model.origin_name,
                ),
                sgSizedBoxHeight,
                SGTextGroupWidget(
                  field: "Pelanggan",
                  value: _model.customer_name,
                ),
                sgSizedBoxHeight,
                SGTextGroupWidget(
                  field: "Tujuan",
                  value: _model.plant_name,
                ),
                sgSizedBoxHeight,
                SGTextGroupWidget(
                  field: "Material",
                  value: _model.product_name,
                ),
                sgSizedBoxHeight,
                SGTextGroupWidget(
                  field: "UJT",
                  value: currencyFormatter.format(_modelUJT.ujt),
                ),
                sgSizedBoxHeight,
                SGAutoCompleteWidget(
                  controller: _fleetController,
                  title: 'Nomor Kendaraan',
                  getData: _fleetData,
                  setData: _getDriver,
                  id: _model.fleet_id,
                  name: _model.plate_no,
                ),
                RadioListTile<DriverList>(
                  title: Text('Supir Batang'),
                  value: DriverList.Batang,
                  groupValue: _driver,
                  onChanged: (DriverList? value) {
                    setState(() {
                      _driver = value;
                    });
                  },
                  activeColor: sgRed,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: dbImageBatang.isNotEmpty
                          ? Hero(
                              tag: 'picture',
                              child: CircleAvatar(
                                maxRadius: size.height * 0.09,
                                backgroundImage: MemoryImage(
                                  base64Decode(dbImageBatang.value),
                                ),
                              ),
                            )
                          : Hero(
                              tag: 'picture',
                              child: CircleAvatar(
                                backgroundColor: sgWhite,
                                maxRadius: size.height * 0.09,
                                backgroundImage:
                                    AssetImage("assets/images/user.png"),
                              ),
                            ),
                    ),
                    sgSizedBoxWidth,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _modelDriver.primary_driver == null
                              ? ""
                              : _modelDriver.primary_driver!.name!,
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
                          _modelDriver.primary_driver == null
                              ? ""
                              : _modelDriver.primary_driver!.phone!,
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
                          _modelDriver.primary_driver == null
                              ? ""
                              : _modelDriver.primary_driver!.bank_name!,
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
                          _modelDriver.primary_driver == null
                              ? ""
                              : _modelDriver.primary_driver!.bank_no!,
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
                          _modelDriver.primary_driver == null
                              ? ""
                              : _modelDriver.primary_driver!.license_type!,
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
                          _modelDriver.primary_driver == null
                              ? ""
                              : _modelDriver.primary_driver!.license_no!,
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
                          _modelDriver.primary_driver == null
                              ? ""
                              : _modelDriver.primary_driver!.license_exp_date!,
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
                  groupValue: _driver,
                  onChanged: (DriverList? value) {
                    setState(() {
                      _driver = value;
                    });
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
                      child: dbImageSerep.isNotEmpty
                          ? Hero(
                              tag: 'picture',
                              child: CircleAvatar(
                                maxRadius: size.height * 0.09,
                                backgroundImage: MemoryImage(
                                  base64Decode(dbImageSerep.value),
                                ),
                              ),
                            )
                          : Hero(
                              tag: 'picture',
                              child: CircleAvatar(
                                backgroundColor: sgWhite,
                                maxRadius: size.height * 0.09,
                                backgroundImage:
                                    AssetImage("assets/images/user.png"),
                              ),
                            ),
                    ),
                    sgSizedBoxWidth,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sgSizedBoxHeight,
                        Text(
                          _modelDriver.secondary_driver == null
                              ? ""
                              : _modelDriver.secondary_driver!.name!,
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
                          _modelDriver.secondary_driver == null
                              ? ""
                              : _modelDriver.secondary_driver!.phone!,
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
                          _modelDriver.secondary_driver == null
                              ? ""
                              : _modelDriver.secondary_driver!.bank_name!,
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
                          _modelDriver.secondary_driver == null
                              ? ""
                              : _modelDriver.secondary_driver!.bank_no!,
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
                          _modelDriver.secondary_driver == null
                              ? ""
                              : _modelDriver.secondary_driver!.license_type!,
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
                          _modelDriver.secondary_driver == null
                              ? ""
                              : _modelDriver.secondary_driver!.license_no!,
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
                          _modelDriver.secondary_driver == null
                              ? ""
                              : _modelDriver
                                  .secondary_driver!.license_exp_date!,
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
                sgSizedBoxHeight,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<autocompleteListModel>> _fleetData(keyword) async {
    _apiResponseAuto = await serviceAutoComplete.GetFleetList(
        _model.bisnis_id, _model.fleet_type_id, keyword);
    List<autocompleteListModel> _models = [];

    if (_apiResponseAuto.data.length == 0) {
      return [];
    }

    for (var i = 0; i < _apiResponseAuto.data.length; i++) {
      _models.add(_apiResponseAuto.data[i]);
    }

    return _models;
  }
}
