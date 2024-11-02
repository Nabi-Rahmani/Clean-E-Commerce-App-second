// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewImpl _$$ReviewImplFromJson(Map<String, dynamic> json) => _$ReviewImpl(
      id: json['id'] as String?,
      userId: json['userId'] as String,
      comment: json['comment'] as String,
      imageUrl: json['imageUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'comment': instance.comment,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt.toIso8601String(),
    };
