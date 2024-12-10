import 'package:json_annotation/json_annotation.dart';

part 'coin_model.g.dart';

@JsonSerializable(
  createToJson: false,
)
class CoinModel {
  const CoinModel({
    required this.name,
  });

  factory CoinModel.fromJson(Map<String, dynamic> json) =>
      _$CoinModelFromJson(json);

  final String name;
}
