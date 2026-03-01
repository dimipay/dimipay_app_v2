import 'package:dimipay_app_v2/app/provider/api_provider.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/jwt.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/services/fingerprint/model.dart';
import 'package:get/get.dart';

class FingerprintRepository {
  final ApiProvider api;

  FingerprintRepository({ApiProvider? api})
      : api = api ?? Get.find<ApiProvider>();

  Future<List<Fingerprint>> getFingerprints() async {
    const String url = '/fingerprint';
    DPHttpResponse response = await api.get(DPHttpRequest(url), [JWT()]);
    return (response.data['fingerprints'] as List)
        .map((e) => Fingerprint(name: e.toString()))
        .toList();
  }

  Future<void> deleteFingerprint({required String name}) async {
    final String encodedName = Uri.encodeComponent(name);
    final String url = '/fingerprint/$encodedName';
    await api.delete(DPHttpRequest(url), [JWT()]);
  }
}
