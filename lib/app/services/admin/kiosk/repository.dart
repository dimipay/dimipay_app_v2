import 'package:dimipay_app_v2/app/provider/api_provider.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/jwt.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/services/admin/kiosk/model.dart';
import 'package:get/get.dart';

class KioskRepository {
  final ApiProvider api;

  KioskRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  Future<Passcode> generatePasscode({required String id}) async {
    String url = '/admin/kiosk/passcode/$id';

    DPHttpResponse response = await api.get(DPHttpRequest(url), [JWT()]);
    return Passcode.fromJson(response.data);
  }

  Future<Map> getKiosks() async {
    String url = '/admin/kiosk';
    DPHttpResponse response = await api.get(DPHttpRequest(url), [JWT()]);

    List<Kiosk> kiosks = (response.data["kiosks"] as List).map((e) => Kiosk.fromJson(e)).toList();

    return {"kiosks": kiosks};
  }
}
