import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:example/features/trade_history/models/history.dart';

part 'account_founds_model.g.dart';

@Entity()
@JsonSerializable()
class AccountFoundsModel implements History {
  @override
  @Id(assignable: true)
  int id;
  @override
  @JsonKey(defaultValue: '')
  String type;
  @override
  @JsonKey(defaultValue: 0)
  double amount;
  @override
  @JsonKey(defaultValue: '')
  String comment;
  @override
  @JsonKey(defaultValue: '')
  String source;
  @override
  @JsonKey(defaultValue: '', name: 'createdAt')
  String date;

  AccountFoundsModel({
    required this.id,
    required this.amount,
    required this.type,
    required this.comment,
    required this.source,
    required this.date,
  });

  factory AccountFoundsModel.fromJson(Map<String, dynamic> json) =>
      _$AccountFoundsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountFoundsModelToJson(this);

  History copyToEntity() {
    return History(
      id: id,
      type: type,
      amount: amount,
      comment: comment,
      date: date,
      source: source,
      commission: 0,
      swap: 0,
    );
  }

  @override
  @JsonKey(defaultValue: 0)
  double commission = 0;

  @override
  @JsonKey(defaultValue: 'found')
  String isA = 'found';

  @override
  @JsonKey(defaultValue: 0)
  double swap = 0;
}
