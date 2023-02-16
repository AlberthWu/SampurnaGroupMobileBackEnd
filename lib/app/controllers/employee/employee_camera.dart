import 'dart:convert';
import 'dart:io';

import 'package:asm/app/constant/color.dart';
import 'package:asm/app/controllers/employee/employee_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';

class EmployeeCamera extends StatefulWidget {
  final String image;

  EmployeeCamera({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  State<EmployeeCamera> createState() => _EmployeeCameraState();
}

class _EmployeeCameraState extends State<EmployeeCamera> {
  File? image;
  final Rx<String> dbImage = ''.obs;

  @override
  void initState() {
    if (widget.image != null) {
      dbImage.value = widget.image;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: sgRed,
        title: Text(
          "Photo",
          style: TextStyle(
            color: sgWhite,
            fontFamily: 'Nexa',
          ),
        ),
        iconTheme: IconThemeData(
          color: sgWhite,
        ),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sgSizedBoxHeight,
              Text(
                'Foto Karyawan',
                style: TextStyle(
                  color: sgRed,
                  fontFamily: 'Nexa',
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              sgSizedBoxHeight,
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => EmployeeImage(
                        image: widget.image,
                      ),
                    ),
                  );
                },
                child: dbImage.isNotEmpty
                    ? Hero(
                        tag: "picture",
                        child: Image.memory(
                          base64Decode(dbImage.value),
                          width: size.width * 0.75,
                          alignment: Alignment.center,
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    : Hero(
                        tag: 'picture',
                        child: CircleAvatar(
                          maxRadius: size.height * 0.09,
                          backgroundImage: AssetImage("assets/images/user.png"),
                        ),
                      ),
              ),
              sgSizedBoxHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: sgRed,
                    child: Text(
                      "Gallery",
                      style: TextStyle(
                        color: sgWhite,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nexa',
                      ),
                    ),
                    onPressed: () {
                      pickImage();
                    },
                  ),
                  MaterialButton(
                    color: sgRed,
                    child: Text(
                      "Camera",
                      style: TextStyle(
                        color: sgWhite,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nexa',
                      ),
                    ),
                    onPressed: () {
                      pickImageC();
                    },
                  ),
                ],
              ),
              sgSizedBoxHeight,
              image != null
                  ? Image.file(
                      image!,
                      width: size.width * 0.75,
                    )
                  : Center(
                      child: Text("No image selected"),
                    ),
              sgSizedBoxHeight,
            ],
          )
        ],
      ),
    );
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}
