import 'package:dimipay_app_v2/app/core/theme/box_decorations.dart';
import 'package:dimipay_app_v2/app/pages/onboarding/controller.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OnboardingPage extends GetView<OnboardingPageController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingPageController>(
      init: OnboardingPageController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: PageView(
              controller: controller.pageController,
              onPageChanged: (index) {
                controller.currentPageIndex.value = index;
              },
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CardRegistrationPage(controller: controller),
                FaceSignRegistrationPage(controller: controller),
                TermsAgreementPage(controller: controller),
                HelpPage(controller: controller),
              ],
            ),
          ),
        );
      },
    );
  }
}

abstract class OnboardingPageBase extends StatelessWidget {
  final String header;
  final String description;
  final OnboardingPageController controller;

  const OnboardingPageBase({
    Key? key,
    required this.header,
    required this.description,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DPAppbar(header: header),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      description,
                      style: DPTypography.paragraph1(color: DPColors.grayscale700),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DPButton(
                isTapEffectEnabled: false,
                onTap: () {
                  controller.nextPage();
                },
                child: Text('나중에 할래요',
                    style: DPTypography.paragraph1Underlined(
                        color: DPColors.grayscale600)),
              ),
              const SizedBox(height: 16),
              DPButton(
                decoration: DPBoxDecorations.box2_1,
                isTapEffectEnabled: true,
                radius: const BorderRadius.all(Radius.circular(10)),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('등록할래요',
                        style: DPTypography.itemDescription(
                            color: DPColors.grayscale100),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CardRegistrationPage extends OnboardingPageBase {
  const CardRegistrationPage({Key? key, required OnboardingPageController controller})
      : super(
    key: key,
    header: '카드를 등록할게요',
    description: '앱에 카드를 등록해야 결제 단말기에서 결제를 진행할 수 있어요.',
    controller: controller,
  );
}

class FaceSignRegistrationPage extends OnboardingPageBase {
  const FaceSignRegistrationPage({Key? key, required OnboardingPageController controller})
      : super(
    key: key,
    header: 'FaceSign을 등록할게요',
    description:
    'FaceSign을 등록하면 결제 단말기에서 FaceSign으로 디미페이 앱 없이 간편하게 결제할 수 있어요.',
    controller: controller,
  );
}

class TermsAgreementPage extends StatefulWidget {
  final OnboardingPageController controller;

  const TermsAgreementPage({Key? key, required this.controller}) : super(key: key);

  @override
  _TermsAgreementPageState createState() => _TermsAgreementPageState();
}

class _TermsAgreementPageState extends State<TermsAgreementPage> {
  bool isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DPAppbar(
          header: '약관에 동의해주세요',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DPButton(
                    isTapEffectEnabled: false,
                    onTap: () {
                      launchUrl(Uri.parse('https://dimipay.notion.site/60322b96c77b4855b8c7b72dcfcaa0eb'));
                    },
                    child: Text('개인정보 보호약관 보기',
                        style: DPTypography.paragraph1Underlined(
                            color: DPColors.grayscale700)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DPButton(
                    isTapEffectEnabled: false,
                    onTap: () {
                      launchUrl(Uri.parse('https://dimipay.notion.site/fa05b169a2d94db6b1dd4acae47c66a6'));
                    },
                    child: Text('서비스 이용약관 보기',
                        style: DPTypography.paragraph1Underlined(
                            color: DPColors.grayscale700)),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DPButton(
                isTapEffectEnabled: false,
                onTap: () {
                  setState(() {
                    isButtonPressed = !isButtonPressed;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: isButtonPressed ? DPBoxDecorations.box2 : DPBoxDecorations.box1,
                      child: Icon(
                        Icons.check_rounded,
                        color: isButtonPressed ? DPColors.grayscale100 : DPColors.grayscale500,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text('개인정보보호약관',
                        style: DPTypography.paragraph2Underlined(
                            color: DPColors.grayscale600)),
                    Text('과 ',
                        style: DPTypography.paragraph2(
                            color: DPColors.grayscale600)),
                    Text('서비스 이용약관',
                        style: DPTypography.paragraph2Underlined(
                            color: DPColors.grayscale600)),
                    Text('에 동의합니다',
                        style: DPTypography.paragraph2(
                            color: DPColors.grayscale600)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              DPButton(
                decoration: isButtonPressed ? DPBoxDecorations.box2_1 : DPBoxDecorations.box1_1,
                isTapEffectEnabled: true,
                radius: const BorderRadius.all(Radius.circular(10)),
                onTap: () {
                  if(isButtonPressed){
                    widget.controller.nextPage();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('다음',
                          style: DPTypography.itemDescription(
                            color: isButtonPressed ? DPColors.grayscale100 : DPColors.grayscale600,)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HelpPage extends OnboardingPageBase {
  const HelpPage({Key? key, required OnboardingPageController controller})
      : super(
    key: key,
    header: '도움말을 읽어주세요',
    description: '도움말은 홈에서 또 확인할 수 있어요',
    controller: controller,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DPAppbar(header: header),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style:
                    DPTypography.paragraph1(color: DPColors.grayscale700),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              ExpandableHelpItem(
                title: '매점은 언제 여나요?',
                details: '매점 운영시간 설명...',
              ),
              SizedBox(height: 16),
              ExpandableHelpItem(
                title: '결제는 어떻게 하나요?',
                details: '결제 방법 설명...',
              ),
              SizedBox(height: 16),
              ExpandableHelpItem(
                title: 'FaceSign은 뭔가요?',
                details: 'FaceSign 기능 설명...',
              ),
              SizedBox(height: 16),
              ExpandableHelpItem(
                title: '쿠폰은 어떻게 쓰나요?',
                details:
                '물품을 찍은 다음, 결제 단말기에서 "결제하기" 버튼을 누르면 내가 가지고 있는 쿠폰을 보여주는 창이 표시됩니다. 이 때 사용할 쿠폰들을 선택하여 결제할 수 있어요.',
              ),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: DPButton(
            decoration: DPBoxDecorations.box2_1,
            isTapEffectEnabled: true,
            radius: const BorderRadius.all(Radius.circular(10)),
            onTap: () {
              controller.nextPage();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('출발',
                      style: DPTypography.itemDescription(
                          color: DPColors.grayscale100)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ExpandableHelpItem extends StatefulWidget {
  final String title;
  final String details;

  const ExpandableHelpItem({
    Key? key,
    required this.title,
    required this.details,
  }) : super(key: key);

  @override
  State<ExpandableHelpItem> createState() => _ExpandableHelpItemState();
}

class _ExpandableHelpItemState extends State<ExpandableHelpItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return DPButton(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      decoration:
      _isExpanded ? DPBoxDecorations.accordion1 : DPBoxDecorations.box1,
      radius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title,
                    style: _isExpanded
                        ? DPTypography.itemTitle(color: DPColors.grayscale700)
                        : DPTypography.description(
                        color: DPColors.grayscale700)),
                Icon(
                  _isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: DPColors.grayscale600,
                  size: 20,
                ),
              ],
            ),
            if (_isExpanded)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(widget.details,
                    style:
                    DPTypography.paragraph2(color: DPColors.grayscale700)),
              ),
          ],
        ),
      ),
    );
  }
}