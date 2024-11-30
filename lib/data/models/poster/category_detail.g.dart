// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryDetail _$CategoryDetailFromJson(Map<String, dynamic> json) =>
    CategoryDetail(
      categoryId: (json['categoryId'] as num).toInt(),
      categoryName: json['categoryName'] as String,
      categoryPhoto: json['categoryPhoto'] as String?,
      categoryPhotoOrigin: json['categoryPhotoOrigin'] as String?,
      parentCategory: (json['parentCategory'] as num?)?.toInt(),
      categoryColor: json['categoryColor'] as String?,
      categoryHidden: (json['categoryHidden'] as num?)?.toInt(),
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      fiscal: (json['fiscal'] as num?)?.toInt(),
      nodiscount: (json['nodiscount'] as num?)?.toInt(),
      taxId: (json['taxId'] as num?)?.toInt(),
      left: (json['left'] as num?)?.toInt(),
      right: (json['right'] as num?)?.toInt(),
      level: (json['level'] as num?)?.toInt(),
      categoryTag: json['categoryTag'] as String?,
      visible: (json['visible'] as List<dynamic>)
          .map((e) => VisibilityDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      id_1c: json['id_1c'] as String?,
    );

Map<String, dynamic> _$CategoryDetailToJson(CategoryDetail instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'categoryPhoto': instance.categoryPhoto,
      'categoryPhotoOrigin': instance.categoryPhotoOrigin,
      'parentCategory': instance.parentCategory,
      'categoryColor': instance.categoryColor,
      'categoryHidden': instance.categoryHidden,
      'sortOrder': instance.sortOrder,
      'fiscal': instance.fiscal,
      'nodiscount': instance.nodiscount,
      'taxId': instance.taxId,
      'left': instance.left,
      'right': instance.right,
      'level': instance.level,
      'categoryTag': instance.categoryTag,
      'visible': instance.visible,
      'id_1c': instance.id_1c,
    };

VisibilityDetail _$VisibilityDetailFromJson(Map<String, dynamic> json) =>
    VisibilityDetail(
      spotId: (json['spotId'] as num?)?.toInt(),
      visible: (json['visible'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VisibilityDetailToJson(VisibilityDetail instance) =>
    <String, dynamic>{
      'spotId': instance.spotId,
      'visible': instance.visible,
    };
