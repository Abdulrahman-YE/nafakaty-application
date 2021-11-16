const String tableCategories = 'catagories';

//class containing columns name
class CategoryFields {
  static const String id = '_id';
  static const String title = 'title';
  static const String createdAt = 'createdAt';

  //List containing all fields name
  static const List<String> values = [id, title, createdAt];
}

class Category {
  final int? id;
  final String title;
  final DateTime createdAt;

  const Category({
    this.id,
    required this.title,
    required this.createdAt,
  });

  //Convert the model to json
  Map<String, Object?> toJson() {
    return {
      CategoryFields.id: id,
      CategoryFields.title: title,
      CategoryFields.createdAt: createdAt.toIso8601String(),
    };
  }

  static Category fromJson(Map<String, Object?> json) {
    return Category(
        id: json[CategoryFields.id] as int?,
        title: json[CategoryFields.title] as String,
        createdAt: DateTime.parse((json[CategoryFields.createdAt]) as String));
  }

  Category copy({int? id, String? title, DateTime? createdAt}) {
    return Category(
        id: id ?? this.id,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt);
  }
}
