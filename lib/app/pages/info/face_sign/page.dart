import 'package:dimipay_app_v2/app/pages/info/face_sign/controller.dart';
import 'package:dimipay_app_v2/app/services/face_sign/state.dart';
import 'package:dimipay_app_v2/app/widgets/animations/animated_showup.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart' show DPAppbar;
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FaceSignPage extends GetView<FaceSignPageController> {
  const FaceSignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DPAnimatedShowUp(
          wait: const Duration(milliseconds: 100),
          slideFrom: const Offset(16, 0),
          child: Column(
            children: [
              const DPAppbar(header: '얼굴 인식 결제'),
              Expanded(
                  child: Obx(
                () => switch (controller.faceSignService.faceSignState) {
                  FaceSignStateInitial() || FaceSignStateLoading() || FaceSignStateFailed() || FaceSignStateRegistering() => FaceSignNotRegistered(controller: controller),
                  FaceSignStatePatching() => FaceSignRegistered(controller: controller),
                  FaceSignStateSuccess(isRegistered: final isRegistered) => isRegistered ? FaceSignRegistered(controller: controller) : FaceSignNotRegistered(controller: controller),
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class FaceSignNotRegistered extends StatelessWidget {
  const FaceSignNotRegistered({
    super.key,
    required this.controller,
  });

  final FaceSignPageController controller;

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return Column(
      children: [
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 24),
              DPAnimatedShowUp(
                wait: const Duration(milliseconds: 500),
                slideFrom: const Offset(0, 4),
                child: SvgPicture.asset(
                  'assets/images/face-sign.svg',
                ),
              ),
              const SizedBox(height: 24),
              DPAnimatedShowUp(
                wait: const Duration(milliseconds: 800),
                slideFrom: const Offset(0, 4),
                child: _DescriptionCard(
                  title: '얼굴 인식 결제란?',
                  description: Text('얼굴 인식 결제은 결제 단말기에서 사용자의 얼굴을 인식하여 결제하는 본인인증 수단이에요. 디미페이 앱으로 본인의 사진을 등록해두면, 디미페이 앱 없이도 빠르게 결제할 수 있어요.', style: textTheme.paragraph1.copyWith(color: colorTheme.grayscale700)),
                ),
              ),
              const DPAnimatedShowUp(
                wait: Duration(milliseconds: 1100),
                slideFrom: Offset(0, 4),
                child: _DescriptionCard(
                  title: '정확한 인식을 위해',
                  description: UnorderedList(['평온한 표정으로 카메라를 응시해주세요.', '등록 중에는 마스크를 벗어주세요. 결제 시에는 마스크를 쓰고 결제할 수 있어요.', '평소에 자주하는 스타일과 메이크업인 상태로 등록하면 결제 시 인식률이 높아져요.']),
                ),
              ),
            ],
          ),
        ),
        DPAnimatedShowUp(
          slideFrom: const Offset(0, 4),
          wait: const Duration(milliseconds: 1600),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
            child: Obx(() => switch (controller.faceSignService.faceSignState) {
                  FaceSignStateSuccess(isRegistered: final isRegistered) => !isRegistered
                      ? DPButton(
                          onTap: controller.registerFaceSign,
                          child: const Text('등록하기'),
                        )
                      : Container(),
                  FaceSignStateFailed() => DPButton(
                      onTap: controller.registerFaceSign,
                      child: const Text('등록하기'),
                    ),
                  FaceSignStateInitial() || FaceSignStateLoading() || FaceSignStatePatching() || FaceSignStateRegistering() => DPButton.loading(
                      backgroundColor: colorTheme.grayscale400,
                      foregroundColor: colorTheme.primaryBrand,
                    ),
                }),
          ),
        ),
      ],
    );
  }
}

class UnorderedList extends StatelessWidget {
  const UnorderedList(this.texts, {super.key});

  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    for (final text in texts) {
      // Add list item
      widgetList.add(UnorderedListItem(text));
      // Add space between items
      widgetList.add(const SizedBox(height: 5.0));
    }

    return Column(children: widgetList);
  }
}

class UnorderedListItem extends StatelessWidget {
  const UnorderedListItem(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('• ', style: textTheme.paragraph1.copyWith(color: colorTheme.grayscale700)),
        Expanded(
          child: Text(text, style: textTheme.paragraph1.copyWith(color: colorTheme.grayscale700)),
        ),
      ],
    );
  }
}

class _DescriptionCard extends StatelessWidget {
  final String title;
  final Widget description;

  const _DescriptionCard({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.header2.copyWith(color: colorTheme.grayscale900),
          ),
          const SizedBox(height: 12),
          description
        ],
      ),
    );
  }
}

class FaceSignRegistered extends StatelessWidget {
  const FaceSignRegistered({
    super.key,
    required this.controller,
  });

  final FaceSignPageController controller;

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/face-sign.svg',
              ),
              const SizedBox(height: 24),
              Text('얼굴 인식 결제가 등록되었어요.', style: textTheme.header2.copyWith(color: colorTheme.grayscale1000)),
            ],
          ),
        ),
        DPGestureDetectorWithOpacityInteraction(
          onTap: controller.deleteFaceSign,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text('등록 삭제하기', style: textTheme.paragraph2Underlined.copyWith(color: colorTheme.grayscale600)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: DPButton(
            onTap: controller.patchFaceSign,
            child: const Text('다시 등록하기'),
          ),
        ),
      ],
    );
  }
}
