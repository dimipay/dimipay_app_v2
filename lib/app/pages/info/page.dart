import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dimipay_app_v2/app/pages/home/controller.dart';

class InfoPage extends GetView<HomePageController> {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
