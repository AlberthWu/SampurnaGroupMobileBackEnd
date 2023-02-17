import 'package:asm/app/models/employee/get.dart';

class driverGetModel {
  final employeeGetModel? primary_driver;
  final employeeGetModel? secondary_driver;

  driverGetModel({
    this.primary_driver,
    this.secondary_driver,
  });

  factory driverGetModel.fromJson(Map<String, dynamic> item) {
    var _employeePrimary;
    var primary = item['primary_driver'];

    if (primary != null) {
      _employeePrimary = employeeGetModel.fromJson(primary);
    } else {
      _employeePrimary = new employeeGetModel();
    }

    var _employeeSecondary;
    var secondary = item['secondary_driver'];

    if (secondary != null) {
      _employeeSecondary = employeeGetModel.fromJson(secondary);
    } else {
      _employeeSecondary = new employeeGetModel();
    }

    return driverGetModel(
      primary_driver: _employeePrimary,
      secondary_driver: _employeeSecondary,
    );
  }
}
