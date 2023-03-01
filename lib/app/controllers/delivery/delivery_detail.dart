import 'dart:convert';
import 'dart:io';

import 'package:asm/app/constant/color.dart';
import 'package:asm/app/models/orders/surat_jalan/get.dart';
import 'package:asm/app/service/orders/delivery.dart';
import 'package:asm/app/views/widgets/information_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:path_provider/path_provider.dart';

class DeliveryDetail extends StatefulWidget {
  final int id;

  const DeliveryDetail({
    Key? key,
    this.id = 0,
  }) : super(key: key);

  @override
  State<DeliveryDetail> createState() => _DeliveryDetailState();
}

class _DeliveryDetailState extends State<DeliveryDetail> {
  deliveryService get serviceDelivery => GetIt.I<deliveryService>();
  final currencyFormatter = NumberFormat('#,##0', 'ID');

  List<File> _imageList = [];

  late deliveryGetModel _model = new deliveryGetModel();
  late String errorMessage = "";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future _getData() async {
    setState(() {
      _isLoading = true;
    });

    await serviceDelivery.GetDelivery(widget.id).then(
      (response) {
        if (response.status) {
          errorMessage = response.message;
          _model = deliveryGetModel();
        } else {
          _model = response.data;

          if (_model.order_image!.length > 0) {
            var id = 1;
            for (var image in _model.order_image!) {
              writeFile(id.toString(), image.toString());
              id++;
            }
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

  void _confirmSJ(int id) async {
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
        _getData();
      }
    });
    setState(() {
      _isLoading = false;
    });
  }

  _save() async {
    setState(() {
      _isLoading = true;
    });
    final result = await serviceDelivery.UploadImage(widget.id, _imageList);

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
        _getData();
      });
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return OverlayLoaderWithAppIcon(
      isLoading: _isLoading,
      overlayBackgroundColor: appWhite,
      circularProgressColor: appWhite,
      appIcon: Image.asset(
        'assets/splash/splash_one.gif',
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: sgRed,
          title: Text(
            "Surat Jalan",
            style: TextStyle(
              color: sgWhite,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nexa',
            ),
          ),
          iconTheme: IconThemeData(
            color: sgWhite,
          ),
          // actions: <Widget>[
          //   _model.assign
          //       ? IconButton(
          //           icon: Icon(
          //             Icons.save_outlined,
          //             color: sgWhite,
          //           ),
          //           onPressed: () => _save(),
          //         )
          //       : Text(""),
          // ],
        ),
        body: Container(
          width: size.width,
          height: size.height,
          child: Container(
            color: appWhite,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: size.width,
                      child: InfoWidget(
                        field: 'Grup Perusahaan',
                        value: _model.company_name,
                      ),
                    ),
                    sgSizedBoxHeight,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                width: size.width * 0.5,
                                child: InfoWidget(
                                  field: 'Nomor SJ',
                                  value: _model.delivery_no,
                                ),
                              ),
                              sgSizedBoxHeight,
                              Container(
                                width: size.width * 0.5,
                                child: InfoWidget(
                                  field: 'Nomor Polisi',
                                  value: _model.plate_no,
                                ),
                              ),
                              sgSizedBoxHeight,
                              Container(
                                width: size.width * 0.5,
                                child: InfoWidget(
                                  field: 'Nomor Rekening',
                                  value: _model.rekening_no,
                                ),
                              ),
                              sgSizedBoxHeight,
                              Container(
                                width: size.width * 0.5,
                                child: InfoWidget(
                                  field: 'Driver',
                                  value: _model.employee_name,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              width: size.width * 0.5,
                              child: InfoWidget(
                                field: 'Tanggal SJ',
                                value: _model.delivery_date,
                              ),
                            ),
                            sgSizedBoxHeight,
                            Container(
                              width: size.width * 0.5,
                              child: InfoWidget(
                                field: 'Jenis',
                                value: _model.fleet_type_name,
                              ),
                            ),
                            sgSizedBoxHeight,
                            Container(
                              width: size.width * 0.5,
                              child: InfoWidget(
                                field: 'Nama Rekening',
                                value: _model.nama_rekening,
                              ),
                            ),
                            sgSizedBoxHeight,
                            Container(
                              width: size.width * 0.5,
                              child: InfoWidget(
                                field: 'UJT',
                                value: currencyFormatter.format(_model.ujt),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    sgSizedBoxHeight,
                    Container(
                      width: size.width,
                      child: InfoWidget(
                        field: 'Asal',
                        value: _model.origin_name,
                      ),
                    ),
                    sgSizedBoxHeight,
                    Container(
                      width: size.width,
                      child: InfoWidget(
                        field: 'Tujuan',
                        value: _model.plant_name,
                      ),
                    ),
                    sgSizedBoxHeight,
                    Container(
                      width: size.width,
                      child: InfoWidget(
                        field: 'Material',
                        value: _model.product_name,
                      ),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                        _save();
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Container(
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
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
