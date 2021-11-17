const String amountTable = 'amounts';

///Represents the table columns
class AmountFields {
  static const String id = '_id';
  static const String value = 'value';
  static const String processType = 'processType';
  static const String target = 'target';
  static const String note = 'note';
  static const String createdAt = 'createdAt';
  static const String categoryId = 'categoryId';

  static const List<String> values = [
    id,
    value,
    processType,
    target,
    note,
    categoryId,
    createdAt
  ];
}

enum processTypes { income, expanse, loan }

///Represents one row in the table
class Amount {
  final int? id;
  final double value;
  final processTypes processType;
  final String target;
  final String? note;
  final int categoryId;
  final DateTime createdAt;

  const Amount(
      {this.id,
      required this.value,
      required this.processType,
      required this.target,
      this.note,
      required this.categoryId,
      required this.createdAt});

  Map<String, Object?> toJson() {
    return {
      AmountFields.id: id,
      AmountFields.value: value,
      AmountFields.processType: processType.index,
      AmountFields.target: target,
      AmountFields.note: note,
      AmountFields.categoryId: categoryId,
      AmountFields.createdAt: createdAt.toIso8601String()
    };
  }

  static Amount fromJson(Map<String, Object?> json) {
    int indx = json[AmountFields.processType] as int;

    return Amount(
        id: json[AmountFields.id] as int?,
        value: json[AmountFields.value] as double,
        processType: processTypes.values[indx],
        target: json[AmountFields.target] as String,
        note: json[AmountFields.note] as String?,
        categoryId: json[AmountFields.categoryId] as int,
        createdAt: DateTime.parse((json[AmountFields.createdAt] as String)));
  }

  Amount copy(
      {int? id,
      double? value,
      processTypes? processType,
      String? target,
      String? note,
      int? categoryId,
      DateTime? createdAt}) {
    return Amount(
        id: id ?? this.id,
        value: value ?? this.value,
        processType: processType ?? this.processType,
        target: target ?? this.target,
        note: note ?? this.note,
        categoryId: categoryId ?? this.categoryId,
        createdAt: createdAt ?? this.createdAt);
  }
}
