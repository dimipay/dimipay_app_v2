import 'package:dimipay_app_v2/app/pages/face_sign/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaceSignPage extends GetView<FaceSignPageController> {
  const FaceSignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FaceSignPage'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => Text(controller.faceSignService.isRegistered ? 'Registered' : 'Not Registered')),
          TextButton(
            onPressed: controller.registerFaceSign,
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: controller.deleteFaceSign,
            child: const Text('Unregister'),
          ),
        ],
      )),
    );
  }
}
