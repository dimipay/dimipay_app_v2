import 'package:dimipay_app_v2/app/pages/onboarding/controller.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';

class ManualPage extends StatelessWidget {
  final OnboardingPageController controller;
  const ManualPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return Column(
      children: [
        const DPAppbar(header: '도움말을 읽어주세요'),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '도움말은 홈에서 또 확인할 수 있어요',
                          style: textTheme.paragraph1.copyWith(color: colorTheme.grayscale700),
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
                      details: '매일 점심시간(12:50~13:40), 저녁시간(18:30~19:40)에 운영되어요. 주말 및 공휴일에는 매주 다르니 공지를 확인해주세요!',
                    ),
                    SizedBox(height: 16),
                    ExpandableHelpItem(
                      title: '결제는 어떻게 하나요?',
                      details: '앱 내 QR을 통한 결제와 얼굴 인식을 통한 결제를 할 수 있어요. 물품을 찍고 결제 대기창에서 잠금해제된 QR을 찍거나, 얼굴 인식 된 상태에서 결제를 진행해 주세요!',
                    ),
                    SizedBox(height: 16),
                    ExpandableHelpItem(
                      title: '얼굴 인식은 뭔가요?',
                      details: '얼굴 인식은 결제 단말기에서 사용자의 얼굴을 인식하여 결제하는 본인인증 수단이에요. 디미페이 앱으로 본인의 사진을 등록해두면, 디미페이 앱 없이도 빠르게 결제할 수 있어요.',
                    ),
                    SizedBox(height: 16),
                    ExpandableHelpItem(
                      title: '쿠폰은 어떻게 쓰나요?',
                      details: '물품을 찍은 다음, 결제 단말기에서 "결제하기" 버튼을 누르면 내가 가지고 있는 쿠폰을 보여주는 창이 표시되어요. 이 때 사용할 쿠폰들을 선택하여 결제할 수 있어요.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: DPButton(
            onTap: () {
              controller.nextPage();
            },
            child: const Text('확인'),
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
    super.key,
    required this.title,
    required this.details,
  });

  @override
  State<ExpandableHelpItem> createState() => _ExpandableHelpItemState();
}

class _ExpandableHelpItemState extends State<ExpandableHelpItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: _isExpanded
            ? BoxDecoration(
                color: colorTheme.grayscale200,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                border: Border.fromBorderSide(BorderSide(
                  color: colorTheme.primaryBrand,
                  width: 2,
                )),
              )
            : BoxDecoration(
                color: colorTheme.grayscale200,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                border: Border.fromBorderSide(BorderSide(
                  color: colorTheme.grayscale300,
                  width: 2,
                )),
              ),
        padding: const EdgeInsets.all(20.0),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.topCenter,
          curve: Curves.easeOut,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.title, style: _isExpanded ? textTheme.itemTitle.copyWith(color: colorTheme.grayscale700) : textTheme.description.copyWith(color: colorTheme.grayscale700)),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: colorTheme.grayscale600,
                    size: 20,
                  ),
                ],
              ),
              if (_isExpanded)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(widget.details, style: textTheme.paragraph2.copyWith(color: colorTheme.grayscale700)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
