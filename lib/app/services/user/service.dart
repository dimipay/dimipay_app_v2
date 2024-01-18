import 'dart:developer';

import 'package:dimipay_app_v2/app/services/user/model.dart';
import 'package:dimipay_app_v2/app/services/user/repository.dart';
import 'package:get/get.dart';

class UserService extends GetxController with StateMixin<User?> {
  final UserRepository repository;

  UserService({UserRepository? repository})
      : repository = repository ?? UserRepository();

  final Rx<User?> _user = Rx(null);
  User? get user => _user.value;

  Future fetchUser() async {
    log("Fetching user info");
    try {
      change(user, status: RxStatus.loading());
      _user.value = await repository.getUserInfo();
      change(user, status: RxStatus.success());
    } catch (e) {
      change(user, status: RxStatus.error());
      rethrow;
    }
  }
}
