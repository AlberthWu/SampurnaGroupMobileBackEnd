class employeeListModel {
  final int id;
  final String nik;
  final String name;
  final String alias;
  final String companyName;

  employeeListModel({
    this.id = 0,
    this.nik = "",
    this.name = "",
    this.alias = "",
    this.companyName = "",
  });

  factory employeeListModel.fromJson(Map<String, dynamic> item) {
    return employeeListModel(
      id: item['id'],
      nik: item['nik'],
      name: item['name'],
      alias: item['alias'],
      companyName: item['company_id']['code'],
    );
  }
}
