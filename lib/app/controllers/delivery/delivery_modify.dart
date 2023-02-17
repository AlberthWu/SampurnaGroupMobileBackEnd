import 'dart:convert';

import 'package:asm/app/constant/color.dart';
import 'package:asm/app/models/api_response.dart';
import 'package:asm/app/models/autocomplete_model.dart';
import 'package:asm/app/models/orders/driver.dart';
import 'package:asm/app/models/orders/surat_jalan/get.dart';
import 'package:asm/app/service/autocomplete_service.dart';
import 'package:asm/app/service/driver.dart';
import 'package:asm/app/service/orders/delivery.dart';
import 'package:asm/app/views/widgets/auto_complete_widget.dart';
import 'package:asm/app/views/widgets/information_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

enum DriverList { Batang, Serep }

class DeliveryModify extends StatefulWidget {
  final int delivery_id;

  const DeliveryModify({
    Key? key,
    this.delivery_id = 0,
  }) : super(key: key);

  @override
  State<DeliveryModify> createState() => _DeliveryModifyState();
}

class _DeliveryModifyState extends State<DeliveryModify> {
  final currencyFormatter = NumberFormat('#,##0', 'ID');
  autoCompleteService get serviceAutoComplete => GetIt.I<autoCompleteService>();
  late APIResponse<List<autocompleteListModel>> _apiResponseAuto;

  deliveryService get serviceDelivery => GetIt.I<deliveryService>();

  driverService get serviceDriver => GetIt.I<driverService>();
  late driverGetModel _modelDriver = new driverGetModel();

  late deliveryGetModel _model;
  late String errorMessage = "";
  bool _isLoading = false;

  TextEditingController _fleetController = TextEditingController();
  DriverList? _driver = DriverList.Batang;

  Rx<String> dbImageBatang = ''.obs;
  Rx<String> dbImageSerep = ''.obs;

  @override
  void initState() {
    super.initState();
    _getDataDelivery();
  }

  _getDataDelivery() async {
    setState(() {
      _isLoading = true;
    });

    await serviceDelivery.GetDelivery(widget.delivery_id).then(
      (response) {
        if (response.status) {
          errorMessage = response.message;
          _model = deliveryGetModel();

          setState(() {
            _isLoading = false;
          });
        } else {
          _model = response.data;
        }
      },
    );

    setState(() {
      _isLoading = false;
    });
  }

  _getDriver(value) async {
    setState(() {});

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
    print('Data');
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: sgRed,
          title: Text(
            "Edit Surat Jalan",
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
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                color: appWhite,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    sgSizedBoxHeight,
                    InfoWidget(
                      field: "Grup Perusahaan",
                      value: _model.company_name,
                    ),
                    sgSizedBoxHeight,
                    InfoWidget(
                      field: "Bisnis Unit",
                      value: _model.bisnis_name,
                    ),
                    sgSizedBoxHeight,
                    InfoWidget(
                      field: "Jenis Transaksi",
                      value: _model.order_type_name,
                    ),
                    sgSizedBoxHeight,
                    InfoWidget(
                      field: "Jenis Kendaraan",
                      value: _model.fleet_type_name,
                    ),
                    sgSizedBoxHeight,
                    InfoWidget(
                      field: "Asal",
                      value: _model.origin_name,
                    ),
                    sgSizedBoxHeight,
                    InfoWidget(
                      field: "Pelanggan",
                      value: _model.customer_name,
                    ),
                    sgSizedBoxHeight,
                    InfoWidget(
                      field: "Tujuan",
                      value: _model.plant_name,
                    ),
                    sgSizedBoxHeight,
                    InfoWidget(
                      field: "Material",
                      value: _model.product_name,
                    ),
                    sgSizedBoxHeight,
                    InfoWidget(
                      field: "UJT",
                      value: currencyFormatter.format(_model.ujt),
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
                                    backgroundColor: appWhite,
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
                              _model.primary_driver == null
                                  ? ""
                                  : _model.primary_driver!.name!,
                              style: TextStyle(
                                color: appBlack,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Nexa',
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              _model.primary_driver == null
                                  ? ""
                                  : _model.primary_driver!.phone!,
                              style: TextStyle(
                                color: appBlack,
                                fontSize: 14.0,
                                fontFamily: 'Nexa',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              _model.primary_driver == null
                                  ? ""
                                  : _model.primary_driver!.bank_name!,
                              style: TextStyle(
                                color: appBlack,
                                fontSize: 14.0,
                                fontFamily: 'Nexa',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              _model.primary_driver == null
                                  ? ""
                                  : _model.primary_driver!.bank_no!,
                              style: TextStyle(
                                color: appBlack,
                                fontSize: 14.0,
                                fontFamily: 'Nexa',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              _model.primary_driver == null
                                  ? ""
                                  : _model.primary_driver!.license_type!,
                              style: TextStyle(
                                color: appBlack,
                                fontSize: 14.0,
                                fontFamily: 'Nexa',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              _model.primary_driver == null
                                  ? ""
                                  : _model.primary_driver!.license_no!,
                              style: TextStyle(
                                color: appBlack,
                                fontSize: 14.0,
                                fontFamily: 'Nexa',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              _model.primary_driver == null
                                  ? ""
                                  : _model.primary_driver!.license_exp_date!,
                              style: TextStyle(
                                color: appBlack,
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
                                    backgroundColor: appWhite,
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
                              _model.secondary_driver == null
                                  ? ""
                                  : _model.secondary_driver!.name!,
                              style: TextStyle(
                                color: appBlack,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Nexa',
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              _model.secondary_driver == null
                                  ? ""
                                  : _model.secondary_driver!.phone!,
                              style: TextStyle(
                                color: appBlack,
                                fontSize: 14.0,
                                fontFamily: 'Nexa',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              _model.secondary_driver == null
                                  ? ""
                                  : _model.secondary_driver!.bank_name!,
                              style: TextStyle(
                                color: appBlack,
                                fontSize: 14.0,
                                fontFamily: 'Nexa',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              _model.secondary_driver == null
                                  ? ""
                                  : _model.secondary_driver!.bank_no!,
                              style: TextStyle(
                                color: appBlack,
                                fontSize: 14.0,
                                fontFamily: 'Nexa',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              _model.secondary_driver == null
                                  ? ""
                                  : _model.secondary_driver!.license_type!,
                              style: TextStyle(
                                color: appBlack,
                                fontSize: 14.0,
                                fontFamily: 'Nexa',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              _model.secondary_driver == null
                                  ? ""
                                  : _model.secondary_driver!.license_no!,
                              style: TextStyle(
                                color: appBlack,
                                fontSize: 14.0,
                                fontFamily: 'Nexa',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              _model.secondary_driver == null
                                  ? ""
                                  : _model.secondary_driver!.license_exp_date!,
                              style: TextStyle(
                                color: appBlack,
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
    );
  }

  Future<List<autocompleteListModel>> _fleetData(keyword) async {
    _apiResponseAuto =
        await serviceAutoComplete.GetFleetList(_model.bisnis_id, keyword);
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
