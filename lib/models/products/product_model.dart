import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {
  const factory ProductModel({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'price') int? price,
    @JsonKey(name: 'description') String? description,
    Category? category,
    @JsonKey(name: 'images') List<String>? images, // Make nullable or use @Default([])
    @JsonKey(name: 'creationAt') DateTime? creationAt,
    @JsonKey(name: 'updatedAt') DateTime? updatedAt,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}



@freezed
abstract class Category with _$Category {
  const factory Category({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'image') String? image,
    @JsonKey(name: 'creationAt') DateTime? creationAt,
    @JsonKey(name: 'updatedAt') DateTime? updatedAt,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
