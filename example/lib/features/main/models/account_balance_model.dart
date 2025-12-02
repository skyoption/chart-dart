class AccountUpdateModel {
  final double? balance;
  final int accountId;
  final double? credit;
  final double? margin;
  AccountUpdateModel({
    required this.credit,
    required this.balance,
    required this.accountId,
    required this.margin,
  });

  Map<String, dynamic> toJson() {
    return {'balance': balance, 'account': accountId, 'credit': credit};
  }

  factory AccountUpdateModel.fromJson(Map<String, dynamic> json) {
    return AccountUpdateModel(
      balance: double.tryParse(json['balance'].toString()),
      accountId: int.tryParse(json['account'].toString()) ?? 0,
      credit: double.tryParse(json['credit'].toString()),
      margin: double.tryParse(json['margin'].toString()),
    );
  }
}
