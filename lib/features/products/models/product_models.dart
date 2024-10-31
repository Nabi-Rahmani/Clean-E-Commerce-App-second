import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
part 'product_models.freezed.dart';

@freezed
class Products with _$Products {
  const factory Products({
    required String id,
    required String userId,
    required String title,
    required String description,
    required double price,
    required List<File> imageUrls,
    @Default(true) bool isAvailable,
    @Default(0.0) double averageRating,
    @Default(0) int reviewCount,
    DateTime? createdAt,
  }) = _Products;
}
