import 'package:example/features/settings/models/schema/app_log_model.dart';

class AppLogEntity {
  final int id;
  final int accountNumber;
  final String event;
  final DateTime createdAt;

  AppLogEntity({
    required this.id,
    required this.accountNumber,
    required this.event,
    required this.createdAt,
  });

  AppLogModel copyToModel() {
    return AppLogModel(
      id: id,
      event: event,
      createdAt: createdAt,
      accountNumber: accountNumber,
    );
  }
}
