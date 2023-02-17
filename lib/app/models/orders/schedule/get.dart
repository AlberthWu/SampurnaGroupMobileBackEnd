class scheduleGetModel {
  final int id;
  final int company_id;
  final String company_name;
  final int bisnis_id;
  final String bisnis_name;
  final String schedule_no;
  final String schedule_date;
  final int order_type_id;
  final String order_type_name;
  final int customer_id;
  final String customer_name;
  final int origin_id;
  final String origin_name;
  final int plant_id;
  final String plant_name;
  final int fleet_type_id;
  final String fleet_type_name;
  final int multi_product;
  final int product_id;
  final String product_name;
  final int fleet_id;
  final String plate_no;

  scheduleGetModel({
    this.id = 0,
    this.company_id = 0,
    this.company_name = "",
    this.bisnis_id = 0,
    this.bisnis_name = "",
    this.schedule_no = "",
    this.schedule_date = "",
    this.order_type_id = 0,
    this.order_type_name = "",
    this.customer_id = 0,
    this.customer_name = "",
    this.origin_id = 0,
    this.origin_name = "",
    this.plant_id = 0,
    this.plant_name = "",
    this.fleet_type_id = 0,
    this.fleet_type_name = "",
    this.multi_product = 0,
    this.product_id = 0,
    this.product_name = "",
    this.fleet_id = 0,
    this.plate_no = "",
  });

  factory scheduleGetModel.fromJson(Map<String, dynamic> item) {
    return scheduleGetModel(
      id: item['id'],
      company_id: item['company_id']['id'],
      company_name: item['company_id']['name'],
      bisnis_id: item['sales_type_id']['id'],
      bisnis_name: item['sales_type_id']['name'],
      schedule_no: item['schedule_no'],
      schedule_date: item['issue_date'],
      order_type_id: item['order_type_id']['id'],
      order_type_name: item['order_type_id']['name'],
      customer_id: item['customer_id']['id'],
      customer_name: item['customer_id']['name'],
      origin_id: item['origin_id']['id'],
      origin_name: item['origin_id']['name'],
      plant_id: item['plant_id']['id'],
      plant_name: item['plant_id']['full_name'],
      fleet_type_id: item['fleet_type_id']['id'],
      fleet_type_name: item['fleet_type_id']['name'],
      multi_product: item['multi_product'],
      product_id: item['product_id']['id'],
      product_name: item['product_id']['name'],
    );
  }
}
