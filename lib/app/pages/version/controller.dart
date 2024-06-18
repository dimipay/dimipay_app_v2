import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionPageController extends GetxController {
  final appVersion = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAppVersion();
  }

  Future<void> fetchAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    appVersion.value = packageInfo.version;
  }
}
