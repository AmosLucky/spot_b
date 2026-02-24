import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_category.freezed.dart';

@freezed
class ProductCategory with _$ProductCategory {
  const factory ProductCategory({
    int? id,
    String? name,
    int? companyId,
    String? image,
    int? productCount,
    String? link,
  }) = _ProductCategory;

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    final links = json['links'];

    return ProductCategory(
      id: int.tryParse(json['id'].toString()),
      name: attributes['name'],
      companyId: attributes['company_id'],
      image: attributes['image'],
      productCount: attributes['product_count'],
      link: links['self'],
    );
  }
}
