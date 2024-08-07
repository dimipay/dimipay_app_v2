import 'package:dimipay_app_v2/app/pages/pin/controller.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  Widget linkToRoute(String route) {
    return TextButton(
      onPressed: () {
        Get.toNamed(route);
      },
      child: Text(route),
    );
  }

  Widget linkToRouteWithArgs(String route, String title, Map<String, dynamic> args) {
    return TextButton(
      onPressed: () {
        Get.toNamed(route, arguments: args);
      },
      child: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Route"),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          linkToRoute(Routes.HOME),
          linkToRoute(Routes.LOGIN),
          linkToRoute(Routes.ONBOARDING),
          linkToRoute(Routes.PIN),
          linkToRouteWithArgs(Routes.PIN, "/edit_pin", {"pinPageType": PinPageType.editPin}),
          linkToRoute(Routes.TRANSACTION),
          linkToRoute(Routes.INFO),
          linkToRoute(Routes.FACESIGN),
          linkToRoute(Routes.PAYMENT),
          linkToRoute(Routes.REGISTER_CARD),
          linkToRoute(Routes.EDIT_CARD),
          linkToRoute(Routes.TRANSACTION_DETAIL),
          linkToRoute(Routes.THEME_SELECT),
          linkToRoute(Routes.VERSION),
          linkToRoute(Routes.LICENSE),
          linkToRoute(Routes.TERMS_OF_SERVICE),
          TextButton(
            onPressed: () {
              Get.find<AuthService>().logout();
            },
            child: const Text('Clear Data'),
          ),
//           TextButton(
//             onPressed: () async {
//               AesGcmEncryptor encryptor = AesGcmEncryptor(secretKey: '570704d9814f97acb8092e859ea9a15c');
//               final res = await encryptor.encrypt('''{
// 	pin: '1313',
// }''');
//               print(res);
//             },
//             child: Text('test encryption'),
//           ),
        ],
      ),
    );
  }
}
