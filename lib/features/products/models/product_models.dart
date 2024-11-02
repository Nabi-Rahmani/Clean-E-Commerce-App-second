import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_models.freezed.dart';

@freezed
class Products with _$Products {
  const factory Products({
    required String id,
    required String userId,
    required String title,
    String? imageUrl,
    required String description,
    required double price,
    List<File>? imageUrls,
    @Default(true) bool isAvailable,
    @Default(0.0) double averageRating,
    @Default(0) int reviewCount,
    DateTime? createdAt,
  }) = _Products;
}
