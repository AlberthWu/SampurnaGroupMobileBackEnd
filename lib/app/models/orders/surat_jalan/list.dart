class deliveryListModel {
  final int id;
  final String? company_name;
  final String? bisnis_unit;
  final String? schedule_no;
  final String? schedule_date;
  final int? urgent;
  final String? urgent_name;
  final String? delivery_no;
  final String? delivery_date;
  final String? counter;
  final String? shift;
  final String? jenis_transaksi;
  final String? origin_name;
  final String? plant_name;
  final String? fleet_type_name;
  final String? product_name;
  final String? plate_no;
  final String? employee_name;
  final String? rekening_no;
  final String? image;
  final int? ujt;

  deliveryListModel({
    this.id = 0,
    this.company_name = "",
    this.bisnis_unit = "",
    this.schedule_no = "",
    this.schedule_date = "",
    this.urgent = 0,
    this.urgent_name = "",
    this.delivery_no = "",
    this.delivery_date = "",
    this.counter = "",
    this.shift = "",
    this.jenis_transaksi = "",
    this.origin_name = "",
    this.plant_name = "",
    this.fleet_type_name = "",
    this.product_name = "",
    this.plate_no = "",
    this.employee_name = "",
    this.rekening_no = "",
    this.image = "",
    this.ujt = 0,
  });

  factory deliveryListModel.fromJson(Map<String, dynamic> item) {
    print(item['reference_no']);
    var urgent = item['schedule_id']['urgent'] == 1 ? "Urgent" : "Reguler";
    var image_data = item['employee_id']['image_data'];
    var image = '';

    if (image_data != null) {
      if (image_data.toString().contains("jpeg")) {
        image = image_data.substring(23, image_data.length);
      } else {
        image = image_data.substring(22, image_data.length);
      }
    }

    return deliveryListModel(
      id: item['id'],
      company_name: item['company_id']['name'],
      bisnis_unit: item['sales_type_id']['name'],
      schedule_no: item['schedule_id']['schedule_no'],
      schedule_date: item['schedule_id']['issue_date'],
      urgent: item['schedule_id']['urgent'],
      urgent_name: urgent,
      delivery_no: item['reference_no'] == null ? "" : item['reference_no'],
      delivery_date: item['issue_date'] == null ? "" : item['issue_date'],
      // counter: item['counter'] == null ? "" : item['counter'],
      // shift: item['shift'] == null ? "" : item['shift'],
      jenis_transaksi: item['order_type_id']['name'],
      origin_name: item['origin_id']['name'],
      plant_name: item['plant_id']['full_name'],
      fleet_type_name: item['fleet_type_id']['name'],
      product_name: item['product_id']['name'],
      plate_no: item['fleet_id']['plate_no'],
      employee_name: item['employee_id']['name'],
      rekening_no: item['employee_id']['bank_no'],
      image: image_data == null ? '' : image,
      ujt: item['ujt'],
    );
  }
}
