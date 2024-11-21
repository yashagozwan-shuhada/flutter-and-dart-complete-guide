import 'package:json_annotation/json_annotation.dart';

part 'book_status_model.g.dart';

@JsonSerializable()
class BookStatusModel {
  final int? status;
  final String? message;

  const BookStatusModel({
    this.status,
    this.message,
  });

  factory BookStatusModel.fromJson(Map<String, dynamic> json) =>
      _$BookStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookStatusModelToJson(this);
}
