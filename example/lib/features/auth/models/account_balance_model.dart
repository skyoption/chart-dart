class AccountUpdateModel {
  final double? balance;
  final int accountId;
  final double? credit;
  AccountUpdateModel(
      {required this.credit, required this.balance, required this.accountId});

  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
      'account': accountId,
      'credit': credit,
    };
  }

  factory AccountUpdateModel.fromJson(Map<String, dynamic> json) {
    return AccountUpdateModel(
      balance: json['balance'] as double?,
      accountId: json['account'] as int,
      credit: json['credit'] as double?,
    );
  }
}
