import 'package:audioplayers/audioplayers.dart';
import 'package:mwidgets/mwidgets.dart';

class Player {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> _play(String path) async {
    try {
      if (_audioPlayer.state == PlayerState.playing) {
        await _audioPlayer.stop();
      }
      await _audioPlayer.play(AssetSource(path));
    } catch (e) {
      kPrint('Error playing sound: $e');
    }
  }

  static Future<void> success() async {
    await _play('sounds/success.wav');
  }

  static Future<void> failure() async {
    await _play('sounds/failure.wav');
  }
}
