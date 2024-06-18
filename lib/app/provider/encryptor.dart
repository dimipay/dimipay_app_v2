import 'dart:convert';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';

class AesGcmEncryptor {
  static Future<String> encrypt(String text, Uint8List key) async {
    final algorithm = AesGcm.with128bits();
    final secretKey = SecretKey(key);
    final nonce = algorithm.newNonce();

    // Encrypt
    final secretBox = await algorithm.encrypt(
      text.codeUnits,
      secretKey: secretKey,
      nonce: nonce,
    );
    return base64Encode([nonce.length] + nonce + secretBox.mac.bytes + secretBox.cipherText);
  }
}
