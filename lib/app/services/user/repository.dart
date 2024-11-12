import 'package:dimipay_app_v2/app/provider/api_provider.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/jwt.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/services/user/model.dart';
import 'package:get/instance_manager.dart';

class UserRepository {
  final ApiProvider api;

  UserRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  Future<User> getUserInfo() async {
    String url = '/users/info';
    DPHttpResponse response = await api.get(DPHttpRequest(url), [JWTMiddleware()]);
    return User.fromJson(response.data);
  }
}
