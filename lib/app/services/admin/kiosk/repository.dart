import 'package:dimipay_app_v2/app/provider/api_interface.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/services/admin/kiosk/model.dart';
import 'package:get/get.dart';

class KioskRepository {
  final ApiProvider api;

  KioskRepository({ApiProvider? api})
      : api = api ?? Get.find<SecureApiProvider>();

  Future<Passcode> generatePasscode({required String id}) async {
    String url = '/admin/kiosk/passcode/$id';

    DPHttpResponse response = await api.get(url);
    return Passcode.fromJson(response.data);
  }

  Future<Map> getKiosks() async {
    String url = '/admin/kiosk';
    DPHttpResponse response = await api.get(url);

    List<Kiosk> kiosks = (response.data["kiosks"] as List)
        .map((e) => Kiosk.fromJson(e))
        .toList();

    return {"kiosks": kiosks};
  }
}
