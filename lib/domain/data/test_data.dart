import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'test_data.g.dart';

@JsonSerializable(explicitToJson: true)
class TestData with EquatableMixin {
  final int errorsCount;
  final Duration duration;

  const TestData({
    required this.errorsCount,
    required this.duration,
  });

  factory TestData.fromJson(Map<String, dynamic> json) => _$TestDataFromJson(json);

  Map<String, dynamic> toJson() => _$TestDataToJson(this);

  @override
  List<Object?> get props => [
        errorsCount,
        duration,
      ];
}
