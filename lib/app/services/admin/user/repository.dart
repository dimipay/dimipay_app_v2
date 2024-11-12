import 'package:dimipay_app_v2/app/provider/api_provider.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:get/get.dart';

class UserManageRepository {
  final ApiProvider api;

  UserManageRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  Future<void> resetPin({required String email}) async {
    String url = '/admin/users/reset-pin';

    Map body = {"email": email};

    await api.patch(DPHttpRequest(url, body: body));
  }
}
