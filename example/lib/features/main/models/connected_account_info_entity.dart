import 'package:example/features/main/models/schema/connected_account_info_model.dart';

class ConnectedAccountInfoEntity {
  int id;
  final String group;
  final String fullName;
  final int leverage;
  double balance;
  final double credit;
  final double equity;
  final double floating;
  final double margin;
  final double marginFree;
  double? marginLevel;
  bool? isSwapFree;
  int? limitPositions;
  int? limitPending;
  int? rights;
  final bool isDefault;
  double marginCallLevel;
  final String connectionMode;
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
    this.marginLevel,
    this.isSwapFree,
    this.limitPositions,
    this.limitPending,
    this.rights,
    required this.isDefault,
    required this.marginCallLevel,
    required this.connectionMode,
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
      marginCallLevel: marginCallLevel,
      connectionMode: connectionMode,
    );
  }
}

extension ConnectedAccountInfoEntityExtension on ConnectedAccountInfoEntity {
  bool get isMainAccount => connectionMode.toUpperCase() == 'MAIN';
}
