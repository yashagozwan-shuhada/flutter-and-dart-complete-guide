import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_model.g.dart';

abstract class UserModel implements Built<UserModel, UserModelBuilder> {
  static Serializer<UserModel> get serializer => _$personSerializer;

  @nullable
  int get id;

  UserModel._();

  factory UserModel([void Function(UserModelBuilder) updated]) = _$UserModel;
}
