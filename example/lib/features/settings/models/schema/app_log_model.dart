import 'package:objectbox/objectbox.dart';
import 'package:example/features/settings/models/app_log_entity.dart';

@Entity()
class AppLogModel {
  @Id(assignable: true)
  int id;
  int accountNumber;
  String event;
  @Property(type: PropertyType.date)
  DateTime createdAt;

  AppLogModel({
    required this.id,
    required this.event,
    required this.createdAt,
    required this.accountNumber,
  });

  AppLogEntity copyToEntity() {
    return AppLogEntity(
      id: id,
      accountNumber: accountNumber,
      event: event,
      createdAt: createdAt,
    );
  }
}
