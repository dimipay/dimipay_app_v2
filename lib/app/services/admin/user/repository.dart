import 'package:dimipay_app_v2/app/provider/api_interface.dart';
import 'package:get/get.dart';

class UserManageRepository {
  final ApiProvider api;

  UserManageRepository({ApiProvider? api}) : api = api ?? Get.find<SecureApiProvider>();

  Future<void> resetPin({required String email}) async {
    String url = '/admin/users/reset-pin';

    Map body = {"email": email};

    await api.patch(url, data: body);
  }
}
