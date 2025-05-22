import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dimipay_app_v2/app/services/admin/coupon/service.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class CouponPageController extends GetxController {
  final CouponService couponService = Get.find<CouponService>();
  final Map<String, GlobalKey> repaintKeys = {};

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic>? args = Get.arguments as Map<String, dynamic>?;
    final String? id = args != null ? args['id'] : null;
    final int? count = args != null ? args['count'] : null;
    if (id != null && count != null) {
      generateCoupon(id: id, count: count);
    }
  }

  Future<void> generateCoupon({required String id, required int count}) async {
    await couponService.generateCoupon(id: id, count: count);
  }

  GlobalKey getCouponKey(String code) {
    GlobalKey key = GlobalKey();
    repaintKeys[code] = key;
    return key;
  }

  Future<void> saveToGallery() async {
    int success = 0;
    int total = 0;

    for (final key in repaintKeys.values) {
      if (key.currentContext == null) {
        total++;
        continue;
      }  
      RenderRepaintBoundary boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        final result = await ImageGallerySaver.saveImage(
          byteData.buffer.asUint8List(),
          quality: 100,
          name: 'coupon_${DateTime.now().millisecondsSinceEpoch}',
        );

        if (result['isSuccess']) {
          success++;
        }
        total++;
      }
    }

    DPSnackBar.open('$success/$total개의 쿠폰이 갤러리에 저장되었습니다.');
  }

  @override
  void onClose() {
    couponService.resetCoupon();
    super.onClose();
  }
}
