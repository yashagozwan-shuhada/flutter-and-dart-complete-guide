import 'dart:convert' show json;

import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  ItemModel({
    this.id,
    this.deleted,
    this.type,
    this.by,
    this.time,
    this.text,
    this.dead,
    this.parent,
    this.kids,
    this.url,
    this.score,
    this.title,
    this.descendants,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  factory ItemModel.fromDb(Map<String, dynamic> data) {
    final map = {
      ...data,
      'deleted': data['deleted'] == null ? null : data['deleted'] == 1,
      'dead': data['dead'] == null ? null : data['dead'] == 1,
      'kids': data['kids'] == null
          ? null
          : (json.decode(data['kids'] as String) as List)
              .map((e) => e as int)
              .toList(),
    };

    return ItemModel.fromJson(map);
  }

  final int? id;
  final bool? deleted;
  final String? type;
  final String? by;
  final int? time;
  final String? text;
  final bool? dead;
  final int? parent;
  final List<int>? kids;
  final String? url;
  final int? score;
  final String? title;
  final int? descendants;

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  Map<String, dynamic> toDb() {
    final data = toJson();

    final deleted = data['deleted'] == null
        ? null
        : data['deleted'] as bool
            ? 1
            : 0;

    final dead = data['dead'] == null
        ? null
        : data['dead'] as bool
            ? 1
            : 0;

    return {
      ...data,
      'deleted': deleted,
      'dead': dead,
      'kids': data['kids'] != null ? json.encode(data['kids']) : null,
    };
  }
}
