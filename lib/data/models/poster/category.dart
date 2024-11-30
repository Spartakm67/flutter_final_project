import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  @JsonKey(name: 'category_id')
  final String categoryId;

  @JsonKey(name: 'category_name')
  final String categoryName;

  @JsonKey(name: 'category_photo')
  final String? categoryPhoto;

  @JsonKey(name: 'category_tag')
  final String? categoryTag;

  @JsonKey(name: 'category_color')
  final String? categoryColor;

    Category({
    required this.categoryId,
    required this.categoryName,
    required this.categoryPhoto,
      this.categoryTag,
      this.categoryColor,
    });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
