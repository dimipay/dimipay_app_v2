import 'package:dimipay_app_v2/app/core/utils/errors.dart';
import 'package:dimipay_app_v2/app/provider/api_interface.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

class AuthRepository {
  final SecureApiProvider secureApi;

  AuthRepository({SecureApiProvider? secureApi}) : secureApi = secureApi ?? Get.find<SecureApiProvider>();

  ///returnes Login Result
  ///throews NotDimigoMailExceptoin if emial provider trying to login is not @dimigo.hs.kr
  Future<Map> loginWithGoogle(String idToken) async {
    String url = '/login/google';
    Map<String, dynamic> header = {
      'Google-Access-Token': idToken,
    };
    try {
      DPHttpResponse response = await secureApi.post(url, options: Options(headers: header));
      return response.data;
    } on DioException catch (e) {
      if (e.response?.data['code'] == 'ERR_NOT_ALLOWED_EMAIL') {
        throw NotDimigoMailException();
      }
      rethrow;
    }
  }

  ///returns accessToken
  Future<String> refreshAccessToken(String refreshToken) async {
    String url = "/auth/refresh";

    Map<String, dynamic> headers = {
      'Authorization': 'Bearer $refreshToken',
    };
    DPHttpResponse response = await secureApi.get(url, options: Options(headers: headers));
    return response.data['accessToken'];
  }

  ///returns map that contains accessToken and refreshToekn
  ///use ['accessToken'] to get accessToken
  ///use ['refreshToken'] to get refreshToken
  ///throws IncorrectPinException when pin wrong
  ///throws PinLockException when pin locked
  ///thows OnboardingTokenException when OnboardingToken is wrong
  Future<Map> onBoardingAuth(String paymentPin, String deviceId, String bioKey) async {
    String url = '/auth/onBoarding';
    Map body = {
      'deviceId': deviceId,
      'bioKey': bioKey,
    };
    try {
      DPHttpResponse response = await secureApi.post(url, data: body, needPinOTP: true);
      return response.data['tokens'];
    } on DioException catch (e) {
      DPHttpResponse response = DPHttpResponse.fromDioResponse(e.response!);
      switch (response.code) {
        case 'ERR_PAYMENT_PIN_NOT_MATCH':
          throw IncorrectPinException(left: response.errors['remainingTryCount']);
      }
    }
    return {};
  }

  Future<void> changePin(String originalPin, String newPin) async {
    String url = '/payment/pin';
    Map<String, String> body = {
      'originalPin': originalPin,
      'resetPin': newPin,
    };
    await secureApi.put(url, data: body);
  }

  Future<void> registerPin(String pin) async {
    String url = '/pin';
    Map<String, String> body = {
      'pin': pin,
    };
    await secureApi.post(url, data: body, encrypt: true);
  }

  Future<void> checkPin(String pin) async {
    String url = "/payment/check";
    Map<String, String> body = {
      "pin": pin,
    };
    try {
      await secureApi.post(url, data: body);
    } on DioException catch (e) {
      DPHttpResponse response = DPHttpResponse.fromDioResponse(e.response!);
      if (e.response?.statusCode == 400) {
        switch (e.response?.data['code']) {
          case 'ERR_PIN_MISMATCH':
            throw IncorrectPinException(left: response.errors['remainingTryCount']);
          case 'PIN_LOCKED':
            throw PinLockException(e.response?.data['message']);
        }
      }
    }
  }

  Future<String> getEncryptionKey(String publicKey) async {
    String url = '/auth/encryption-keys';
    publicKey = publicKey.replaceAll('\n', '\\r\\n');
    Map<String, dynamic> headers = {
      'Encryption-Public-Key': publicKey,
    };
    DPHttpResponse response = await secureApi.get(url, options: Options(headers: headers));
    return response.data['encryptionKey'];
  }
}
