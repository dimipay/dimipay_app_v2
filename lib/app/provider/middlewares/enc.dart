import 'dart:convert';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';
import 'package:dimipay_app_v2/app/provider/middleware.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:get/get.dart';

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

class EncryptBody extends ApiMiddleware {
  Future<String> encryptData(dynamic data) {
    AuthService authService = Get.find<AuthService>();
    return AesGcmEncryptor.encrypt(json.encode(data), authService.aes.key!);
  }

  @override
  Future<DPHttpResponse> handle(DPHttpRequest request, Future<DPHttpResponse> Function(DPHttpRequest) next) async {
    request.headers['content-type'] = 'application/octet-stream';
    request.body = await encryptData(request.body);
    return next(request);
  }

  @override
  EncryptBody copy() {
    return EncryptBody();
  }
}
