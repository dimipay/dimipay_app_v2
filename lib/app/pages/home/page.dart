import 'package:dimipay_app_v2/app/pages/home/styles/boxDecorations.dart';
import 'package:dimipay_app_v2/app/pages/home/widgets/PaymentQR.dart';
import 'package:dimipay_app_v2/app/pages/home/widgets/button.dart';
import 'package:dimipay_design_kit/utils/dimipay_colors.dart';
import 'package:dimipay_design_kit/utils/dimipay_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:dimipay_app_v2/app/pages/home/controller.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DPColors.grayscale200,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/logoTitle.svg',
                  width: 16,
                  height: 16,
                ),
                const Spacer(),
                const Row(
                  children: [
                    Icon(Icons.support_agent_rounded,
                        size: 24, color: DPColors.grayscale600),
                    SizedBox(width: 24),
                    Icon(Icons.help_rounded,
                        size: 24, color: DPColors.grayscale600),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  DPButton(
                    onTap: () {},
                    decoration: DPBoxDecorations.container1,
                    radius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 21,
                            backgroundImage:
                            AssetImage('assets/images/profileExample.jpg'),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('서승표',
                                    style: DPTypography.itemTitle(
                                        color: DPColors.grayscale900)),
                                Text('내 결제수단, 생체인증 관리',
                                    style: DPTypography.token(
                                        color: DPColors.grayscale600)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(Icons.arrow_forward_ios_rounded,
                              size: 16, color: DPColors.grayscale500),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: DPBoxDecorations.container1,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('결제 바코드',
                                      style: DPTypography.itemTitle(
                                          color: DPColors.grayscale900)),
                                  Text('결제 단말기에 바코드를 읽혀주세요',
                                      style: DPTypography.token(
                                          color: DPColors.grayscale600)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                const SizedBox(
                                  width: 34.0,
                                  height: 34.0,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                    // value: 1,
                                    color: DPColors.grayscale400,
                                  ),
                                ),
                                Text('18',
                                    style: DPTypography.token(
                                        color: DPColors.grayscale600)),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 24),
                        const DPPaymentQR(isLocked: true),
                        const SizedBox(height: 24),
                        DPButton(
                          onTap: () {},
                          isTapEffectEnabled: false,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/images/paymentRequired.svg',
                                  width: 40, height: 40),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '결제수단 등록',
                                    style: DPTypography.itemDescription(
                                        color: DPColors.grayscale900),
                                    // style: TextStyle(
                                    //   fontSize: 14,
                                    //   height: 18 / 14,
                                    //   fontWeight: FontWeight.w600,
                                    //   color: DPColors.grayscale800,
                                    // ),
                                  ),
                                  Text('주 결제수단 등록하기',
                                      style: DPTypography.token(
                                          color: DPColors.grayscale600)),
                                ],
                              ),
                              const Spacer(),
                              const SizedBox(width: 12),
                              const Icon(Icons.arrow_forward_ios_rounded,
                                  size: 16, color: DPColors.grayscale500),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: DPBoxDecorations.container1,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('내 쿠폰',
                                  style: DPTypography.itemTitle(
                                      color: DPColors.grayscale900)),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded,
                            size: 16, color: DPColors.grayscale500),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
