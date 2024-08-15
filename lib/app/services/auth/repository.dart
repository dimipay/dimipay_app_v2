import 'package:dimipay_app_v2/app/core/utils/errors.dart';
import 'package:dimipay_app_v2/app/provider/api_interface.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/services/auth/key_manager/jwt.dart';
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
      'DP-GOOGLE-ACCESS-TOKEN': idToken,
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
  Future<JwtToken> refreshAccessToken(String refreshToken) async {
    String url = "/auth/refresh";

    Map<String, dynamic> headers = {
      'Authorization': 'Bearer $refreshToken',
    };
    DPHttpResponse response = await secureApi.get(url, options: Options(headers: headers));
    return JwtToken(accessToken: response.data['tokens']['accessToken'], refreshToken: response.data['tokens']['refreshToken']);
  }

  ///returns map that contains accessToken and refreshToekn
  ///use ['accessToken'] to get accessToken
  ///use ['refreshToken'] to get refreshToken
  ///throws IncorrectPinException when pin wrong
  ///throws PinLockException when pin locked
  ///thows OnboardingTokenException when OnboardingToken is wrong
  Future<Map> onBoardingAuth(String paymentPin, String deviceId, String bioKey, String onBoardingToken) async {
    String url = '/auth/onBoarding';
    Map body = {
      'deviceId': deviceId,
      'bioKey': bioKey,
    };
    Map<String, dynamic> headers = {
      'Authorization': 'Bearer $onBoardingToken',
    };
    try {
      DPHttpResponse response = await secureApi.post(
        url,
        data: body,
        needPinOTP: true,
        options: Options(headers: headers),
      );
      return response.data['tokens'];
    } on DioException catch (e) {
      DPHttpResponse response = DPHttpResponse.fromDioResponse(e.response!);
      switch (response.code) {
        case 'ERR_PAYMENT_PIN_NOT_MATCH':
          throw IncorrectPinException(left: response.errors['remainingTryCount']);
        default:
          rethrow;
      }
    }
  }

  Future<void> changePin(String newPin) async {
    String url = '/pin';
    Map<String, String> body = {
      'pin': newPin,
    };
    await secureApi.put(url, data: body, needPinOTP: true);
  }

  Future<void> registerPin(String pin, String onBoardingToken) async {
    String url = '/pin';
    Map<String, dynamic> headers = {
      'Authorization': 'Bearer $onBoardingToken',
    };
    Map<String, String> body = {
      'pin': pin,
    };
    await secureApi.post(url, options: Options(headers: headers), data: body, encrypt: true);
  }

  Future<void> checkPin(String pin) async {
    String url = "/pin/otp";
    Map<String, String> body = {
      "pin": pin,
    };
    try {
      await secureApi.post(url, data: body, encrypt: true);
    } on DioException catch (e) {
      DPHttpResponse response = DPHttpResponse.fromDioResponse(e.response!);
      switch (response.code) {
        case 'ERR_PAYMENT_PIN_NOT_MATCH':
          throw IncorrectPinException(left: response.errors['remainingTryCount']);
        case 'ERR_TRY_LIMIT_EXCEEDED':
          throw PinLockException(response.message!);
      }
    }
  }

  Future<String> getEncryptionKey(String publicKey, String onBoardingToken) async {
    String url = '/auth/encryption-keys';
    publicKey = publicKey.replaceAll('\n', '\\r\\n');
    Map<String, dynamic> headers = {
      'Dp-Public-Key': publicKey,
      'Authorization': 'Bearer $onBoardingToken',
    };
    DPHttpResponse response = await secureApi.get(url, options: Options(headers: headers));
    return response.data['encryptionKey'];
  }
}
