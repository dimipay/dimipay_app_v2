import 'package:dimipay_app_v2/app/pages/home/controller.dart';
import 'package:dimipay_app_v2/app/provider/api_provider.dart';
import 'package:dimipay_app_v2/app/provider/providers/dio.dart';
import 'package:dimipay_app_v2/app/services/bio_auth/service.dart';
import 'package:dimipay_app_v2/app/services/pay/repository.dart';
import 'package:dimipay_app_v2/app/services/pay/service.dart';
import 'package:dimipay_app_v2/app/services/payment/service.dart';
import 'package:dimipay_app_v2/app/services/push/service.dart';
import 'package:dimipay_app_v2/app/services/user/service.dart';
import 'package:get/get.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController());
    Get.lazyPut(() => UserService());
    Get.lazyPut(() => PaymentService());
    Get.lazyPut(() => PayService(PayRepository(Get.find<ApiProvider>() as DioApiProvider)));
    Get.lazyPut(() => LocalAuthService());
    Get.lazyPut(() => PushService());
  }
}
