class ujtGetModel {
  final int id;
  final int ujt;
  final int ritase;

  ujtGetModel({
    this.id = 0,
    this.ujt = 0,
    this.ritase = 0,
  });

  factory ujtGetModel.fromJson(Map<String, dynamic> item) {
    return ujtGetModel(
      id: item['id'],
      ujt: item['ujt'],
      ritase: item['ritase'],
    );
  }
}
