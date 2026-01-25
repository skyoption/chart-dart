import 'package:candle_chart/entity/fav_entity.dart';
import 'package:candle_chart/utils/isar.dart';
import 'package:candle_chart/utils/kprint.dart';
import 'package:isar_community/isar.dart';

mixin Fav {
  List<FavEntity> favs = [];

  Future<void> getFavs() async {
    try {
      final res = await KChart.query.favEntitys.where().findAll();
      favs = res;
    } catch (e) {
      return kPrint(e.toString());
    }
  }

  bool isFav(String value) {
    return favs.any((element) => element.name == value);
  }

  bool get isEmptyFav => favs.isEmpty;

  Future<void> fav(String value) async {
    if (favs.any((element) => element.name == value)) {
      final index = favs.indexWhere((element) => element.name == value);
      return removeFromFav(index);
    } else {
      return addToFav(value);
    }
  }

  Future<void> addToFav(String value) async {
    final item = FavEntity(name: value);
    favs.add(item);
    await KChart.write(query: (db) async {
      await db.favEntitys.put(item);
    });
  }

  Future<void> removeFromFav(int index) async {
    final id = favs[index].id;
    favs.removeAt(index);
    await KChart.write(query: (db) async {
      await db.favEntitys.delete(id);
    });
  }
}
