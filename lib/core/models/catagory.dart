const String tableCatagories = 'catagories';

//class containing columns name
class CatagoryFields {
  static const String id = '_id';
  static const String title = 'title';
  static const String createdAt = 'createdAt';

  //List containing all fields name
  static const List<String> values = [id, title, createdAt];
}

class Catagory {
  final int? id;
  final String title;
  final DateTime createdAt;

  const Catagory({
    this.id,
    required this.title,
    required this.createdAt,
  });

  //Convert the model to json
  Map<String, Object?> toJson() {
    return {
      CatagoryFields.id: id,
      CatagoryFields.title: title,
      CatagoryFields.createdAt: createdAt.toIso8601String(),
    };
  }

  static Catagory fromJson(Map<String, Object?> json) {
    return Catagory(
        id: json[CatagoryFields.id] as int?,
        title: json[CatagoryFields.title] as String,
        createdAt: DateTime.parse([CatagoryFields.createdAt] as String));
  }

  Catagory copy({int? id, String? title, DateTime? createdAt}) {
    return Catagory(
        id: id ?? this.id,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt);
  }
}
