import 'dart:io';

import 'package:asm/app/constant/color.dart';
import 'package:asm/app/models/orders/surat_jalan/get.dart';
import 'package:asm/app/service/orders/delivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ScheduleDetail extends StatefulWidget {
  final int id;

  const ScheduleDetail({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ScheduleDetail> createState() => _ScheduleDetailState();
}

class _ScheduleDetailState extends State<ScheduleDetail> {
  deliveryService get service => GetIt.I<deliveryService>();
  final currencyFormatter = NumberFormat('#,##0', 'ID');
  final ImagePicker _picker = ImagePicker();

  List<XFile> _imageList = [];

  File? image;

  late deliveryGetModel _model;
  late String errorMessage = "";
  bool _isLoading = false;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    setState(() {
      _isLoading = true;
    });

    await service.GetDelivery(widget.id).then(
      (response) {
        if (response.status) {
          errorMessage = response.message;
          _model = deliveryGetModel();
        } else {
          _model = response.data;
        }
      },
    );

    setState(() {
      _isLoading = false;
    });
  }

  Future openGallery() async {
    try {
      final List<XFile>? selectedImage = await _picker.pickMultiImage();

      if (selectedImage!.isNotEmpty) {
        for (var element in selectedImage) {
          _imageList.add(element);
        }
      }

      setState(() {});
      // final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      // if (image == null) return;

      // final imageTemp = File(image.path);

      // setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future openCamera() async {
    try {
      final XFile? selectedImage =
          await _picker.pickImage(source: ImageSource.camera);

      if (selectedImage!.path.isNotEmpty) {
        _imageList.add(selectedImage);
      }

      setState(() {});
      // final image = await ImagePicker().pickImage(source: ImageSource.camera);

      // if (image == null) return;

      // final imageTemp = File(image.path);

      // setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void _confirmSJ(int id) async {
    final result = await service.PostConfirm(id);

    final title = 'Information';
    final text = result.status ? (result.message) : 'Your unit was updated';

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
  }

  Widget ScheduleFeature(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: appBlack,
            fontSize: 14.0,
            fontFamily: 'Nexa',
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: sgRed,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Nexa',
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
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
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                width: size.width,
                height: size.height,
                child: Container(
                  child: Expanded(
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
                              child: ScheduleFeature(
                                'Grup Perusahaan',
                                _model.company_name,
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
                                        child: ScheduleFeature(
                                          'Nomor Jadwal',
                                          _model.delivery_no,
                                        ),
                                      ),
                                      sgSizedBoxHeight,
                                      Container(
                                        width: size.width * 0.5,
                                        child: ScheduleFeature(
                                          'Nomor Polisi',
                                          _model.plate_no,
                                        ),
                                      ),
                                      sgSizedBoxHeight,
                                      Container(
                                        width: size.width * 0.5,
                                        child: ScheduleFeature(
                                          'Nomor Rekening',
                                          _model.rekening_no,
                                        ),
                                      ),
                                      sgSizedBoxHeight,
                                      Container(
                                        width: size.width * 0.5,
                                        child: ScheduleFeature(
                                          'Driver',
                                          _model.employee_name,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: size.width * 0.5,
                                      child: ScheduleFeature(
                                        'Tanggal Jadwal',
                                        _model.delivery_date,
                                      ),
                                    ),
                                    sgSizedBoxHeight,
                                    Container(
                                      width: size.width * 0.5,
                                      child: ScheduleFeature(
                                        'Jenis',
                                        _model.fleet_type_name,
                                      ),
                                    ),
                                    sgSizedBoxHeight,
                                    Container(
                                      width: size.width * 0.5,
                                      child: ScheduleFeature(
                                        'Nama Rekening',
                                        _model.nama_rekening,
                                      ),
                                    ),
                                    sgSizedBoxHeight,
                                    Container(
                                      width: size.width * 0.5,
                                      child: ScheduleFeature(
                                        'UJT',
                                        currencyFormatter.format(_model.ujt),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            sgSizedBoxHeight,
                            Container(
                              width: size.width,
                              child: ScheduleFeature(
                                'Asal',
                                _model.origin_name,
                              ),
                            ),
                            sgSizedBoxHeight,
                            Container(
                              width: size.width,
                              child: ScheduleFeature(
                                'Tujuan',
                                _model.plant_name,
                              ),
                            ),
                            sgSizedBoxHeight,
                            Container(
                              width: size.width,
                              child: ScheduleFeature(
                                'Material',
                                _model.product_name,
                              ),
                            ),
                            sgSizedBoxHeight,
                            _model.assign
                                ? Container(
                                    width: size.width,
                                    height: size.height * 0.42,
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
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                  ),
                                                  itemCount: _imageList.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Stack(
                                                        fit: StackFit.expand,
                                                        children: [
                                                          Image.file(
                                                            File(
                                                              _imageList[index]
                                                                  .path,
                                                            ),
                                                            fit: BoxFit.cover,
                                                          ),
                                                          Positioned(
                                                            top: 4,
                                                            right: 4,
                                                            child: Container(
                                                              color: sgGray
                                                                  .withOpacity(
                                                                      0.7),
                                                              child: IconButton(
                                                                onPressed: () {
                                                                  _imageList
                                                                      .removeAt(
                                                                          index);
                                                                  setState(
                                                                      () {});
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .delete_outline,
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
                                        // image != null
                                        //     ? Image.file(
                                        //         image!,
                                        //         height: size.height * 0.3,
                                        //       )
                                        //     : const Text(
                                        //         'No image selected',
                                        //         textAlign: TextAlign.center,
                                        //         style: TextStyle(
                                        //           fontFamily: 'Nexa',
                                        //         ),
                                        //       ),
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
                                                openGallery();
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
                                                openCamera();
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
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
                                          onPressed: () =>
                                              _confirmSJ(_model.id),
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
      ),
    );
  }
}
