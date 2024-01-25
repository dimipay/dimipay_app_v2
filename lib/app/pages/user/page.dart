import 'package:dimipay_app_v2/app/pages/user/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserPage extends GetView<UserPageController> {
  const UserPage({super.key});

  Widget _userProfile() {
    return controller.userService.obx(
      (state) => CircleAvatar(
        backgroundImage: NetworkImage(
          state!.profileImage,
        ),
      ),
      onLoading: const CircleAvatar(),
    );
  }

  Widget _userName() {
    return controller.userService.obx(
      (state) => Text(
        state!.name,
      ),
      onLoading: const Text(
        'loading...',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserPage'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _userProfile(),
            _userName(),
          ],
        ),
      ),
    );
  }
}
