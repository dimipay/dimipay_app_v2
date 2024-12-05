import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:dimipay_app_v2/app/services/admin/coupon/service.dart';
import 'package:get/get.dart';

class CouponPageController extends GetxController {
  final CouponService couponService = Get.find<CouponService>();
  final GlobalKey repaintKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    final String? couponTypeId = Get.arguments as String?;
    if (couponTypeId != null) {
      generateCoupon(id: couponTypeId);
    }
  }

  Future<void> generateCoupon({required String id}) async {
    await couponService.generateCoupon(id: id);
  }

  Future<void> saveToGallery() async {
    RenderRepaintBoundary boundary = repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData != null) {
      final result = await ImageGallerySaver.saveImage(byteData.buffer.asUint8List(), quality: 100, name: 'coupon_${DateTime.now().millisecondsSinceEpoch}');

      if (result['isSuccess']) {
        DPSnackBar.open('쿠폰이 갤러리에 저장되었습니다.');
      } else {
        DPErrorSnackBar().open('쿠폰 저장을 실패했습니다.');
      }
    }
  }

  @override
  void onClose() {
    couponService.resetCoupon();
    super.onClose();
  }
}
