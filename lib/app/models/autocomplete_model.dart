class autocompleteListModel {
  final int id;
  final String name;

  autocompleteListModel({
    this.id = 0,
    this.name = "",
  });

  factory autocompleteListModel.fromJson(Map<String, dynamic> item) {
    return autocompleteListModel(
      id: item['id'],
      name: item['name'],
    );
  }

  String showAsString() {
    return '${this.name}';
  }

  String getIDString() {
    return this.id.toString();
  }

  int getID() {
    return this.id;
  }

  String getName() {
    return this.name;
  }
}
