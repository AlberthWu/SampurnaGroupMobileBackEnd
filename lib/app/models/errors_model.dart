class errorsModel {
  final String? field;
  final String? errors;

  const errorsModel({
    this.field,
    this.errors,
  });

  factory errorsModel.fromJson(Map<String, dynamic> item) {
    return errorsModel(
      field: item['field'],
      errors: item['errors'],
    );
  }
}
