import 'dart:convert';
import 'dart:io';

import 'package:asm/app/constant/color.dart';
import 'package:asm/app/controllers/employee/employee_image.dart';
import 'package:asm/app/models/api_response.dart';
import 'package:asm/app/models/autocomplete_model.dart';
import 'package:asm/app/models/orders/driver.dart';
import 'package:asm/app/models/orders/surat_jalan/get.dart';
import 'package:asm/app/models/orders/ujt.dart';
import 'package:asm/app/service/autocomplete_service.dart';
import 'package:asm/app/service/driver.dart';
import 'package:asm/app/service/orders/delivery.dart';
import 'package:asm/app/service/orders/ujt.dart';
import 'package:asm/app/views/widgets/auto_complete_widget.dart';
import 'package:asm/app/views/widgets/information_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:path_provider/path_provider.dart';

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

  ujtService get serviceUJT => GetIt.I<ujtService>();
  late ujtGetModel _modelUJT = new ujtGetModel();

  late deliveryGetModel _model = new deliveryGetModel();
  late String errorMessage = "";
  bool _isLoading = false;
  bool _getUJTFlag = false;
  bool _getDriverFlag = false;

  List<File> _imageList = [];

  TextEditingController _fleetController = TextEditingController();
  DriverList? _driver = DriverList.Batang;

  Rx<String> dbImageBatang = ''.obs;
  Rx<String> dbImageSerep = ''.obs;

  @override
  void initState() {
    super.initState();
    _getDataDelivery();
  }

  Future _getDataDelivery() async {
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

          if (_model.order_image!.length > 0) {
            var id = 1;
            for (var image in _model.order_image!) {
              writeFile(id.toString(), image.toString());
              id++;
            }
          }

          _fleetController.text = _model.fleet_id.toString();

          if (_model.primary_status == 1) {
            setState(() {
              _driver = DriverList.Batang;
            });
          } else {
            setState(() {
              _driver = DriverList.Serep;
            });
          }
        }
      },
    );

    setState(() {
      _isLoading = false;
    });
  }

  Future _getDriver(value) async {
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

          setState(() {
            _getDriverFlag = true;
          });

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

  Future _getUJT() async {
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

          if (_modelUJT.ujt > 0) {
            setState(() {
              _getUJTFlag = true;
            });
          }
        }
      },
    );

    setState(() {
      _isLoading = false;
    });
  }

  Future pickImageGallery() async {
    try {
      final image = await ImagePicker().pickMultiImage();

      if (image.isNotEmpty) {
        for (var file in image) {
          final imageTemp = File(file.path);
          _imageList.add(imageTemp);
        }
      }
      setState(() {});
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      _imageList.add(imageTemp);
      setState(() {});
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void writeFile(id, image_string) async {
    File _result;
    final decodedBytes = base64Decode(image_string);
    final directory = await getApplicationDocumentsDirectory();
    final imageName = id + ".png";
    _result = File('${directory.path}/${imageName}');
    _result.writeAsBytesSync(List.from(decodedBytes));
    _imageList.add(_result);
  }

  Future _confirmSJ(int id) async {
    setState(() {
      _isLoading = true;
    });
    final result = await serviceDelivery.PostConfirm(id);

    final title = 'Information';
    final text = result.message;

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
    ).then((data) {
      if (result.data) {
        _getDataDelivery();
      }
    });
    setState(() {
      _isLoading = false;
    });
  }

  Future _save() async {
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
        ? _getDriverFlag
            ? _modelDriver.primary_driver!.id.toString()
            : _model.primary_driver!.id.toString()
        : _getDriverFlag
            ? _modelDriver.secondary_driver == null
                ? "0"
                : _modelDriver.secondary_driver!.id.toString()
            : _model.secondary_driver == null
                ? "0"
                : _model.secondary_driver!.id.toString();
    form['ujt_id'] =
        _getUJTFlag ? _modelUJT.id.toString() : _model.ujt_id.toString();
    form['ujt'] =
        _getUJTFlag ? _modelUJT.ujt.toString() : _model.ujt.toString();
    form['primary_status'] = _driver == DriverList.Batang ? "1" : "0";
    form['secondary_status'] = _driver == DriverList.Serep ? "1" : "0";

    final result = await serviceDelivery.PutDelivery(widget.delivery_id, form);

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
      if (!result.status) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DeliveryModify(
              delivery_id: data.id,
            ),
          ),
        );
      }
    });
    setState(() {
      _isLoading = false;
    });
  }

  Future _upload() async {
    setState(() {
      _isLoading = true;
    });
    final result =
        await serviceDelivery.UploadImage(widget.delivery_id, _imageList);

    final title = 'Information';
    final text = result.message;

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
      setState(() {
        _getDataDelivery();
      });
    });
    setState(() {
      _isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: OverlayLoaderWithAppIcon(
        isLoading: _isLoading,
        overlayBackgroundColor: sgGrey,
        circularProgressColor: sgGold,
        appIcon: Image.asset(
          'assets/logo/logo.png',
        ),
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
              _model.assign
                  ? Text("")
                  : IconButton(
                      icon: Icon(
                        Icons.save_outlined,
                        color: sgWhite,
                      ),
                      onPressed: () => _save(),
                    ),
            ],
          ),
          body: Container(
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
                _model.assign
                    ? Container(
                        width: size.width,
                        height: size.height * 0.28,
                        child: Column(
                          children: [
                            Text(
                              'Upload Foto',
                              style: TextStyle(
                                color: sgRed,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Nexa',
                              ),
                            ),
                            sgSizedBoxHeight,
                            Expanded(
                              child: _imageList.length > 0
                                  ? GridView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _imageList.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (_) => EmployeeImage(
                                                    image: File(
                                                        _imageList[index].path),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Stack(
                                              fit: StackFit.expand,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  child: Image.file(
                                                    File(
                                                      _imageList[index].path,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 4,
                                                  right: 4,
                                                  child: Container(
                                                    child: IconButton(
                                                      onPressed: () {
                                                        _imageList
                                                            .removeAt(index);
                                                        setState(() {});
                                                      },
                                                      icon: Icon(
                                                        Icons.delete_outline,
                                                        color: sgRed,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : Text(
                                      'No image selected',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: sgGold,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Nexa',
                                      ),
                                    ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                OutlinedButton(
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.all(
                                      BorderSide(
                                        color: appBlack,
                                        width: 1.0,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    "Gallery",
                                    style: TextStyle(
                                      color: appBlack,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Nexa',
                                    ),
                                  ),
                                  onPressed: () {
                                    pickImageGallery();
                                  },
                                ),
                                OutlinedButton(
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.all(
                                      BorderSide(
                                        color: appBlack,
                                        width: 1.0,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    "Camera",
                                    style: TextStyle(
                                      color: appBlack,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Nexa',
                                    ),
                                  ),
                                  onPressed: () {
                                    pickImageCamera();
                                  },
                                ),
                                OutlinedButton(
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.all(
                                      BorderSide(
                                        color: sgRed,
                                        width: 1.0,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    "Upload",
                                    style: TextStyle(
                                      color: sgRed,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Nexa',
                                    ),
                                  ),
                                  onPressed: () {
                                    _upload();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _getUJT();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: sgWhite,
                                border: Border.all(
                                  width: 1,
                                  color: sgGreen,
                                ),
                              ),
                              alignment: Alignment(0, 0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Get UJT',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: appBlack,
                                    fontFamily: 'Nexa',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          sgSizedBoxHeight,
                          InfoWidget(
                            field: "No Kendaraan",
                            value: _model.plate_no,
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
                                          backgroundImage: AssetImage(
                                              "assets/images/user.png"),
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
                                        : _model
                                            .primary_driver!.license_exp_date!,
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
                                          backgroundImage: AssetImage(
                                              "assets/images/user.png"),
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
                                        : _model
                                            .secondary_driver!.license_type!,
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
                                        : _model.secondary_driver!
                                            .license_exp_date!,
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
                          Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: sgGreen,
                                  ),
                                  child: Text(
                                    "Terima",
                                    style: TextStyle(
                                      color: appWhite,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Nexa',
                                    ),
                                  ),
                                  onPressed: () => _confirmSJ(_model.id),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: sgRed,
                                  ),
                                  child: Text(
                                    "Tolak",
                                    style: TextStyle(
                                      color: appWhite,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Nexa',
                                    ),
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          )
                        ],
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
