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
          child: SingleChildScrollView(
            child: Column(
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
                        details: '물품을 찍은 다음, 결제 단말기에서 "결제하기" 버튼을 누르면 내가 가지고 있는 쿠폰을 보여주는 창이 표시됩니다. 이 때 사용할 쿠폰들을 선택하여 결제할 수 있어요.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: DPButton(
            decoration: BoxDecoration(
              color: colorTheme.primaryBrand,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.fromBorderSide(BorderSide(
                color: colorTheme.primaryBrand,
                width: 1,
              )),
            ),
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
                  Text('확인', style: textTheme.itemDescription.copyWith(color: DPLightThemeColors().grayscale100)),
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
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return DPButton(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
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
                width: 1,
              )),
            ),
      radius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
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
    );
  }
}
