import 'package:example/app.dart';
import 'package:path_provider/path_provider.dart';
import 'package:example/core/consts/exports.dart';
import 'package:example/core/framework/mtoast.dart';
import 'package:example/core/framework/premissions.dart';

@injectable
class Download {
  final Permissions permissions;

  Download({
    required this.permissions,
  });

  Future<void> save({
    Uint8List? bytes,
    String? string,
    required String filename,
    String extension = 'png',
  }) async {
    Directory? directory;
    await permissions.requestStoragePermission();
    try {
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
        MToast.showError(message: err.toString());
      }
      File file = File('${directory!.path}/$filename.$extension');
      if (bytes != null) file.writeAsBytesSync(bytes, flush: true);
      if (string != null) file.writeAsStringSync(string, flush: true);
      MToast.showSuccess(message: SkyTrading.tr.saved);
    } catch (e) {
      MToast.showError(message: e.toString());
    }
  }
}
