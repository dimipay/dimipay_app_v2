import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dimipay_app_v2/app/pages/home/controller.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home Page'),
      )
    );
  }
}
