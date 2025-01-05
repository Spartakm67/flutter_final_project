import 'package:json_annotation/json_annotation.dart';

part 'category_detail.g.dart';

@JsonSerializable()
class CategoryDetail {
  final int categoryId;
  final String categoryName;
  final String? categoryPhoto;
  final String? categoryPhotoOrigin;
  final int? parentCategory;
  final String? categoryColor;
  final int? categoryHidden;
  final int? sortOrder;
  final int? fiscal;
  final int? nodiscount;
  final int? taxId;
  final int? left;
  final int? right;
  final int? level;
  final String? categoryTag;
  final List<VisibilityDetail> visible;
  final String? id_1c;

  CategoryDetail({
    required this.categoryId,
    required this.categoryName,
    this.categoryPhoto,
    this.categoryPhotoOrigin,
    this.parentCategory,
    this.categoryColor,
    this.categoryHidden,
    this.sortOrder,
    this.fiscal,
    this.nodiscount,
    this.taxId,
    this.left,
    this.right,
    this.level,
    this.categoryTag,
    required this.visible,
    this.id_1c,
  });

  /// Factory-конструктор для створення об'єкта з JSON.
  factory CategoryDetail.fromJson(Map<String, dynamic> json) {
    return CategoryDetail(
      categoryId: json['category_id'] as int,
      categoryName: json['category_name'] as String? ?? 'Unknown',
      categoryPhoto: json['category_photo'] as String?,
      categoryPhotoOrigin: json['category_photo_origin'] as String?,
      parentCategory: json['parent_category'] as int?,
      categoryColor: json['category_color'] as String?,
      categoryHidden: json['category_hidden'] as int?,
      sortOrder: json['sort_order'] as int?,
      fiscal: json['fiscal'] as int?,
      nodiscount: json['nodiscount'] as int?,
      taxId: json['tax_id'] as int?,
      left: json['left'] as int?,
      right: json['right'] as int?,
      level: json['level'] as int?,
      categoryTag: json['category_tag'] as String?,
      visible: (json['visible'] as List<dynamic>)
          .map((item) => VisibilityDetail.fromJson(item as Map<String, dynamic>))
          .toList(),
      id_1c: json['id_1c'] as String?,
    );
  }

  /// Метод для конвертації об'єкта в JSON.
  Map<String, dynamic> toJson() => _$CategoryDetailToJson(this);
}

@JsonSerializable()
class VisibilityDetail {
  final int? spotId;
  final int? visible;

  VisibilityDetail({
    this.spotId,
    this.visible,
  });

  /// Factory-конструктор для створення об'єкта з JSON.
  factory VisibilityDetail.fromJson(Map<String, dynamic> json) {
    return VisibilityDetail(
      spotId: json['spot_id'] as int?,
      visible: json['visible'] as int?,
    );
  }

  /// Метод для конвертації об'єкта в JSON.
  Map<String, dynamic> toJson() => _$VisibilityDetailToJson(this);
}
