import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPageController extends GetxController {
  final RxInt currentPageIndex = 0.obs;
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void nextPage() {
    if (currentPageIndex.value < 3) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offAndToNamed(Routes.HOME);
    }
  }
}
