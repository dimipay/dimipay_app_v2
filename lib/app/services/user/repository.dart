import 'package:dimipay_app_v2/app/provider/api_interface.dart';
import 'package:dimipay_app_v2/app/services/user/model.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

class UserRepository {
  final ApiProvider api;

  UserRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  Future<User> getUserInfo() async {
    String url = '/user/me';
    Response response = await api.get(url);
    return User.fromJson(response.data);
  }
}
