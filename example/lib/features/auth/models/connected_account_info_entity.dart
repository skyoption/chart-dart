import 'package:example/features/auth/models/schema/connected_account_info_model.dart';

class ConnectedAccountInfoEntity {
  int id;
  final String group;
  final String fullName;
  final int leverage;
  final double credit;
  final double equity;
  final double floating;
  final double margin;
  final double marginFree;
  final bool isDefault;
  double balance;
  double marginLevel;
  bool isSwapFree;
  int limitPositions;
  int limitPending;
  int rights;

  ConnectedAccountInfoEntity({
    required this.id,
    required this.group,
    required this.fullName,
    required this.leverage,
    required this.balance,
    required this.credit,
    required this.equity,
    required this.floating,
    required this.margin,
    required this.marginFree,
    required this.marginLevel,
    required this.isSwapFree,
    required this.limitPositions,
    required this.limitPending,
    required this.rights,
    required this.isDefault,
  });

  ConnectedAccountInfoModel toModel() {
    return ConnectedAccountInfoModel(
      id: id,
      group: group,
      leverage: leverage,
      balance: balance,
      credit: credit,
      equity: equity,
      floating: floating,
      fullName: fullName,
      margin: margin,
      marginFree: marginFree,
      marginLevel: marginLevel,
      isSwapFree: isSwapFree,
      limitPositions: limitPositions,
      limitPending: limitPending,
      rights: rights,
      isDefault: isDefault,
    );
  }
}
