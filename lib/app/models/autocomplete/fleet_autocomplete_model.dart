class fleetAutocompleteModel {
  final int id;
  final String business_name;
  final String fleet_type_name;
  final String plate_no;

  fleetAutocompleteModel({
    this.id = 0,
    this.business_name = "",
    this.fleet_type_name = "",
    this.plate_no = "",
  });

  factory fleetAutocompleteModel.fromJson(Map<String, dynamic> item) {
    return fleetAutocompleteModel(
      id: item['id'],
      business_name: item['sales_type_id']['name'],
      fleet_type_name: item['fleet_type_id']['name'],
      plate_no: item['plate_no'],
    );
  }
}
