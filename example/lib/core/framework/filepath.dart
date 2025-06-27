import 'package:path_provider/path_provider.dart';
import 'package:example/core/consts/exports.dart';

@injectable
class FilePath {
  Future<String?> getDocumentsPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Documents');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err) {
      kPrint(err.toString());
    }
    return directory?.path;
  }

  Future<String> getCachePath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationCacheDirectory();
      } else {
        directory = await getTemporaryDirectory();
      }
    } catch (err) {
      kPrint(err.toString());
    }
    return directory?.path ?? '';
  }
}
