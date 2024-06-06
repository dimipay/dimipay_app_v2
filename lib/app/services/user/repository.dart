import 'package:dimipay_app_v2/app/provider/api_interface.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/services/user/model.dart';
import 'package:get/instance_manager.dart';

class UserRepository {
  final ApiProvider api;

  UserRepository({ApiProvider? api}) : api = api ?? Get.find<SecureApiProvider>();

  Future<User> getUserInfo() async {
    String url = '/users/info';
    DPHttpResponse response = await api.get(url);
    return User.fromJson(response.data);
  }
}
