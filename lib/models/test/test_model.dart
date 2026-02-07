
import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_model.freezed.dart';
part 'test_model.g.dart';

@freezed
abstract class TestModel with _$TestModel {
   factory TestModel({
    @Default('') String name
   }) = _TestModel;
   factory TestModel.fromJson(Map<String, dynamic> json) => _$TestModelFromJson(json);
}