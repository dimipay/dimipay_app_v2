import 'package:dimipay_app_v2/app/core/utils/errors.dart';
import 'package:dimipay_app_v2/app/provider/api_provider.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/enc.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/jwt.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/pin.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/provider/providers/dio.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AuthRepository {
  final ApiProvider api;

  AuthRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  ///returnes Login Result
  ///throews NotDimigoMailExceptoin if emial provider trying to login is not @dimigo.hs.kr
  Future<Map> loginWithGoogle(String idToken) async {
    String url = '/login/google';
    Map<String, dynamic> header = {
      'DP-GOOGLE-ACCESS-TOKEN': idToken,
    };
    try {
      DPHttpResponse response = await api.post(DPHttpRequest(url, headers: header));
      return response.data;
    } on DioException catch (e) {
      if (e.response?.data['code'] == 'ERR_NOT_ALLOWED_EMAIL') {
        throw NotDimigoMailException();
      }
      rethrow;
    }
  }

  Future<Map> loginWithPassword({required String email, required String password}) async {
    String url = '/login/password';

    Map body = {"email": email, "password": password};

    try {
      DPHttpResponse response = await api.post(DPHttpRequest(url, body: body));
      return response.data;
    } on DioException catch (e) {
      if (e.response?.data['code'] == 'ERR_WRONG_CREDENTIALS') {
        throw WrongCredentialsException(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_NOT_PASSWORD_USER') {
        throw NotPasswordUserException(message: e.response?.data['message']);
      }
      rethrow;
    }
  }

  ///returns map that contains accessToken and refreshToekn
  ///use ['accessToken'] to get accessToken
  ///use ['refreshToken'] to get refreshToken
  ///throws IncorrectPinException when pin wrong
  ///throws PinLockException when pin locked
  ///thows OnboardingTokenException when OnboardingToken is wrong
  Future<Map> onBoardingAuth(
    String paymentPin,
    String deviceId,
    String bioKey,
    String onBoardingToken, {
    int? accessTokenLife,
    int? refreshTokenLife,
  }) async {
    String url = '/auth/onBoarding';
    Map body = {
      'deviceId': deviceId,
      'bioKey': bioKey,
    };
    Map<String, dynamic> headers = {
      'Authorization': 'Bearer $onBoardingToken',
    };
    if (accessTokenLife != null) {
      headers['DP-DCH-ACCESS-TOKEN-LIFE'] = accessTokenLife.toString();
    }
    if (refreshTokenLife != null) {
      headers['DP-DCH-REFRESH-TOKEN-LIFE'] = refreshTokenLife.toString();
    }
    try {
      DPHttpResponse response = await api.post(DPHttpRequest(url, body: body, headers: headers), [OTP()]);
      return response.data['tokens'];
    } on DioException catch (e) {
      DPHttpResponse response = e.response!.toDPHttpResponse();
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
    await api.put(DPHttpRequest(url, body: body), [JWT(), OTP()]);
  }

  Future<void> registerPin(String pin, String onBoardingToken) async {
    String url = '/pin';
    Map<String, dynamic> headers = {
      'Authorization': 'Bearer $onBoardingToken',
    };
    Map<String, String> body = {
      'pin': pin,
    };
    await api.post(DPHttpRequest(url, body: body, headers: headers), [JWT(), EncryptBody()]);
  }

  ///returns otp
  Future<String> checkPin(String pin) async {
    String url = "/pin/otp";
    Map<String, String> body = {
      "pin": pin,
    };
    try {
      DPHttpResponse response = await api.post(DPHttpRequest(url, body: body), [JWT(), EncryptBody()]);
      return response.data['otp'];
    } on DioException catch (e) {
      DPHttpResponse response = e.response!.toDPHttpResponse();
      switch (response.code) {
        case 'ERR_PAYMENT_PIN_NOT_MATCH':
          throw IncorrectPinException(left: response.errors['remainingTryCount']);
        case 'ERR_TRY_LIMIT_EXCEEDED':
          throw PinLockException(response.message!);
      }
    }
    return '';
  }

  Future<String> getEncryptionKey(String publicKey, String onBoardingToken) async {
    String url = '/auth/encryption-keys';
    publicKey = publicKey.replaceAll('\n', '\\r\\n');
    Map<String, dynamic> headers = {
      'Dp-Public-Key': publicKey,
      'Authorization': 'Bearer $onBoardingToken',
    };
    DPHttpResponse response = await api.get(DPHttpRequest(url, headers: headers));
    return response.data['encryptionKey'];
  }
}
