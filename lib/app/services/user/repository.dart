import 'package:dimipay_app_v2/app/provider/api_provider.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/from_cache.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/jwt.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/save_cache.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/services/user/model.dart';
import 'package:get/instance_manager.dart';

class UserRepository {
  final ApiProvider api;

  UserRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  Future<User> getUserInfoFromCache() async {
    String url = '/users/info';
    DPHttpResponse response = await api.get(DPHttpRequest(url), [FromCache()]);
    return User.fromJson(response.data);
  }

  Future<User> getUserInfo() async {
    String url = '/users/info';
    DPHttpResponse response = await api.get(DPHttpRequest(url), [JWT(), SaveCache()]);
    return User.fromJson(response.data);
  }
}
