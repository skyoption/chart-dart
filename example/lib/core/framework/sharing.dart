import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:example/core/consts/exports.dart';

@injectable
class Sharing extends Cubit<FlowState> {
  Sharing() : super(FlowState());

  Future<void> share(String text, {String image = ''}) async {
    emit(state.copyWith(type: StateType.loadingPopUp));
    try {
      if (image.isEmpty) {
        emit(state.copyWith(type: StateType.success));
        await SharePlus.instance.share(
          ShareParams(text: text, subject: 'Look what I found!'),
        );
        return;
      }
      final response = await http.get(Uri.parse(image));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final tempDir = await getTemporaryDirectory();
        final file = await File('${tempDir.path}/image.png').create();
        await file.writeAsBytes(bytes);
        emit(state.copyWith(type: StateType.success));
        await SharePlus.instance.share(
          ShareParams(text: text, files: [XFile(file.path)]),
        );
      } else {
        throw Exception('Failed to download image');
      }
    } catch (e) {
      emit(state.copyWith(type: StateType.success));
      await SharePlus.instance.share(
        ShareParams(text: text, subject: 'Look what I found!'),
      );
      return;
    }
  }
}
