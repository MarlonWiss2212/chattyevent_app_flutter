import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EncryptionUtils {
  static final Encrypter _encrypter = Encrypter(AES(
    Key.fromUtf8(dotenv.get("MESSAGE_ENCRYPTION_KEY")),
    mode: AESMode.ctr,
    padding: null,
  ));

  static String encrypt({required String text}) {
    final iv = IV.fromSecureRandom(16);
    final encrypted = _encrypter.encrypt(text, iv: iv);
    return '${iv.base64}:${encrypted.base64}';
  }

  static String decrypt({required String encryptedText}) {
    final textParts = encryptedText.split(':');
    final iv = IV.fromBase64(textParts[0]);
    final encrypted = Encrypted.fromBase64(textParts[1]);
    return _encrypter.decrypt(encrypted, iv: iv);
  }
}
