import 'package:dimipay_app_v2/app/services/cache/service.dart';
import 'package:dimipay_app_v2/app/services/user/repository.dart';
import 'package:dimipay_app_v2/app/services/user/state.dart';
import 'package:get/get.dart';

class UserService extends GetxController {
  final UserRepository repository;

  UserService({UserRepository? repository}) : repository = repository ?? UserRepository();

  final Rx<UserState> _user = Rx(const UserStateInitial());
  UserState get userState => _user.value;

  Future _fetchFromCache() async {
    try {
      UserState newUserState = UserStateSuccess(value: await repository.getUserInfoFromCache());
      if (userState is! UserStateSuccess) {
        _user.value = newUserState;
      }
    } on CacheNotExistException {}
  }

  Future _fetchFromRemote() async {
    UserState newUserState = UserStateSuccess(value: await repository.getUserInfo());
    _user.value = newUserState;
  }

  Future fetchUser() async {
    try {
      _user.value = const UserStateLoading();
      _fetchFromCache();
      _fetchFromRemote();
    } on Exception catch (e) {
      _user.value = UserStateFailed(exception: e);
      rethrow;
    }
  }
}
