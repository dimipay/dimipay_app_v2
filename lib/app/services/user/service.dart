import 'package:dimipay_app_v2/app/services/user/repository.dart';
import 'package:dimipay_app_v2/app/services/user/state.dart';
import 'package:get/get.dart';

class UserService extends GetxController {
  final UserRepository repository;

  UserService({UserRepository? repository}) : repository = repository ?? UserRepository();

  final Rx<UserState> _user = Rx(const UserStateInitial());
  UserState get userState => _user.value;

  Future fetchUser() async {
    try {
      _user.value = const UserStateLoding();
      _user.value = UserStateSuccess(value: await repository.getUserInfo());
    } on Exception catch (e) {
      _user.value = UserStateFailed(exception: e);
      rethrow;
    }
  }
}
