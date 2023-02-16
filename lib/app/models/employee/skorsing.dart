class skorsingModel {
  int id;
  final String start_date;
  final String end_date;
  final String memo;

  skorsingModel(
      {this.id = 0, this.start_date = "", this.end_date = "", this.memo = ""});

  factory skorsingModel.fromJson(Map<String, dynamic> item) {
    return skorsingModel(
      id: item['id'],
      start_date: item['start_date'] == null ? "" : item['start_date'],
      end_date: item['end_date'] == null ? "" : item['end_date'],
      memo: item['memo'] == null ? "" : item['memo'],
    );
  }
}
