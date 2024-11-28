// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      id: (json['id'] as num?)?.toInt(),
      deleted: json['deleted'] as bool?,
      type: json['type'] as String?,
      by: json['by'] as String?,
      time: (json['time'] as num?)?.toInt(),
      text: json['text'] as String?,
      dead: json['dead'] as bool?,
      parent: (json['parent'] as num?)?.toInt(),
      kids: (json['kids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      url: json['url'] as String?,
      score: (json['score'] as num?)?.toInt(),
      title: json['title'] as String?,
      descendants: (json['descendants'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'id': instance.id,
      'deleted': instance.deleted,
      'type': instance.type,
      'by': instance.by,
      'time': instance.time,
      'text': instance.text,
      'dead': instance.dead,
      'parent': instance.parent,
      'kids': instance.kids,
      'url': instance.url,
      'score': instance.score,
      'title': instance.title,
      'descendants': instance.descendants,
    };
