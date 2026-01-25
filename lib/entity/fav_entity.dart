import 'package:isar_community/isar.dart';

part 'fav_entity.g.dart';

@collection
class FavEntity {
  Id id = Isar.autoIncrement;
  String name;

  FavEntity({
    this.name = '',
  });
}
