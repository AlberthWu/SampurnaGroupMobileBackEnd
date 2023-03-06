import 'package:asm/app/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_time_picker/date_time_picker.dart';

class SGDatetimePickerWidget extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final bool enabled;

  const SGDatetimePickerWidget({
    Key? key,
    required this.controller,
    required this.title,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<SGDatetimePickerWidget> createState() => _SGDatetimePickerWidgetState();
}

class _SGDatetimePickerWidgetState extends State<SGDatetimePickerWidget> {
  @override
  void initState() {
    super.initState();

    Intl.defaultLocale = "en_US";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
      ),
      child: DateTimePicker(
        enabled: widget.enabled,
        type: DateTimePickerType.dateTimeSeparate,
        dateMask: 'd-MM-yyyy',
        controller: widget.controller,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        icon: Icon(
          Icons.event,
          color: sgRed,
        ),
        dateLabelText: widget.title,
        timeLabelText: "",
        locale: const Locale('en', 'US'),
        use24HourFormat: true,
        selectableDayPredicate: (date) {
          if (date.weekday == 6 || date.weekday == 7) {
            return false;
          }
          return true;
        },
        onChanged: (val) => widget.controller.text,
        // validator: (val) {
        //   setState(() => _valueToValidate2 = val ?? '');
        //   return null;
        // },
        // onSaved: (val) => setState(() => _valueSaved2 = val ?? ''),
      ),
    );
  }
}
