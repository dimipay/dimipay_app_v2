import 'package:dimipay_app_v2/app/pages/admin/api_url_settings/binding.dart';
import 'package:dimipay_app_v2/app/pages/admin/api_url_settings/page.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionPageController extends GetxController {
  final appVersion = ''.obs;
  int _versionTapCount = 0;
  DateTime? _lastVersionTapAt;

  static const int _requiredVersionTapCount = 5;
  static const Duration _tapInterval = Duration(milliseconds: 800);

  @override
  void onInit() {
    super.onInit();
    fetchAppVersion();
  }

  Future<void> fetchAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    appVersion.value = packageInfo.version;
  }

  void onVersionTextTap() {
    final DateTime now = DateTime.now();

    if (_lastVersionTapAt == null ||
        now.difference(_lastVersionTapAt!) > _tapInterval) {
      _versionTapCount = 0;
    }

    _lastVersionTapAt = now;
    _versionTapCount++;

    if (_versionTapCount >= _requiredVersionTapCount) {
      _versionTapCount = 0;
      _lastVersionTapAt = null;
      Get.to(
        () => const ApiUrlSettingsPage(),
        binding: ApiUrlSettingsPageBinding(),
        transition: Transition.cupertino,
      );
    }
  }
}
