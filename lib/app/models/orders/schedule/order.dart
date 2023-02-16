class orderListModel {
  final int id;
  final String reference_no;
  final String plate_no;
  final String coor_name;
  final String employee_name;
  final String fleet_type_name;
  final String formation_name;

  orderListModel({
    this.id = 0,
    this.reference_no = "",
    this.plate_no = "",
    this.coor_name = "",
    this.employee_name = "",
    this.fleet_type_name = "",
    this.formation_name = "",
  });

  factory orderListModel.fromJson(Map<String, dynamic> item) {
    return orderListModel(
      id: item['id'],
      reference_no: item['reference_no'],
      plate_no: item['plate_no'],
      coor_name: item['coor_name'],
      employee_name: item['employee_name'],
      fleet_type_name: item['fleet_type_name'],
      formation_name: item['formation_name'],
    );
  }
}
