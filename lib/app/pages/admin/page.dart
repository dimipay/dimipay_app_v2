import 'package:dimipay_app_v2/app/pages/admin/controller.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminPage extends GetView<AdminPageController> {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ADMIN',
          style: textTheme.header1.copyWith(color: colorTheme.grayscale1000),
        ),
      ),
      body: SafeArea(
          child: Center(
        child: Text('You Are ADMIN!',
            style: textTheme.header1.copyWith(color: colorTheme.primaryBrand)),
      )),
    );
  }
}
