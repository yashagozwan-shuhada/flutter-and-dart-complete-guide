import 'package:json_annotation/json_annotation.dart';

part 'coordinate_model.g.dart';

@JsonSerializable()
class CoordinateModel {
  const CoordinateModel({
    this.latitude,
    this.longitude,
    this.isMocked,
  });

  factory CoordinateModel.fromJson(Map<String, dynamic> json) =>
      _$CoordinateModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinateModelToJson(this);

  final double? latitude;
  final double? longitude;
  final bool? isMocked;
}
