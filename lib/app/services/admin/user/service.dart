import 'package:dimipay_app_v2/app/services/admin/user/repository.dart';
import 'package:get/get.dart';

class UserManageService extends GetxController {
  final UserManageRepository repository;

  UserManageService({UserManageRepository? repository})
      : repository = repository ?? UserManageRepository();

  Future resetPin({required String email}) async {
    try {
      await repository.resetPin(email: email);
    } catch (e) {
      rethrow;
    }
  }
}
