// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookStatusModel _$BookStatusModelFromJson(Map<String, dynamic> json) =>
    BookStatusModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$BookStatusModelToJson(BookStatusModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
