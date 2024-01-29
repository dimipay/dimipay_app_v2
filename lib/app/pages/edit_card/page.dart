import 'package:dimipay_app_v2/app/pages/edit_card/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditCardPage extends GetView<EditCardPageController> {
  const EditCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('EditCardPage')),
      body: SafeArea(
        child: Center(
          child: Text('EditCardPage is working'),
        ),
      ),
    );
  }
}
