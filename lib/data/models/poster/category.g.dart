// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      categoryId: json['category_id'] as String,
      categoryName: json['category_name'] as String,
      categoryPhoto: json['category_photo'] as String?,
      categoryTag: json['category_tag'] as String?,
      categoryColor: json['category_color'] as String?,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'category_photo': instance.categoryPhoto,
      'category_tag': instance.categoryTag,
      'category_color': instance.categoryColor,
    };
