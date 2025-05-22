import 'package:dimipay_app_v2/app/core/utils/async.dart';
import 'package:dimipay_app_v2/app/services/user/repository.dart';
import 'package:dimipay_app_v2/app/services/user/state.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class UserService extends GetxController {
  final UserRepository repository;

  UserService({UserRepository? repository}) : repository = repository ?? UserRepository();

  final Rx<UserState> _user = Rx(const UserStateInitial());
  UserState get userState => _user.value;

  Future _fetchFromCache() async {
    UserState newUserState = UserStateSuccess(value: await repository.getUserInfoFromCache());
    if (userState is! UserStateSuccess) {
      _user.value = newUserState;
    }
  }

  Future _fetchFromRemote() async {
    try {
      UserState newUserState = UserStateSuccess(value: await repository.getUserInfo());
      _user.value = newUserState;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return;
      }
      _user.value = UserStateFailed(exception: e);
    }
  }

  Future fetchUser() async {
    _user.value = const UserStateLoading();
    return anySuccess([_fetchFromCache(), _fetchFromRemote()]);
  }
}
