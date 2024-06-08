import 'package:dimipay_app_v2/app/pages/onboarding/controller.dart';
import 'package:dimipay_app_v2/app/widgets/appbar.dart';
import 'package:dimipay_app_v2/app/widgets/button.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAgreementPage extends StatefulWidget {
  final OnboardingPageController controller;

  const TermsAgreementPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<TermsAgreementPage> createState() => _TermsAgreementPageState();
}

class _TermsAgreementPageState extends State<TermsAgreementPage> {
  bool isTermAgreed = false;

  @override
  Widget build(BuildContext context) {
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
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
                  GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse('https://dimipay.notion.site/60322b96c77b4855b8c7b72dcfcaa0eb'));
                    },
                    child: Text('개인정보 보호약관 보기', style: textTheme.paragraph1Underlined.copyWith(color: colorTheme.grayscale700)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse('https://dimipay.notion.site/fa05b169a2d94db6b1dd4acae47c66a6'));
                    },
                    child: Text('서비스 이용약관 보기', style: textTheme.paragraph1Underlined.copyWith(color: colorTheme.grayscale700)),
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
              GestureDetector(
                onTap: () {
                  setState(() {
                    isTermAgreed = !isTermAgreed;
                    if (isTermAgreed) {
                      HapticFeedback.selectionClick();
                    }
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: isTermAgreed
                            ? BoxDecoration(
                                color: colorTheme.primaryBrand,
                                borderRadius: const BorderRadius.all(Radius.circular(16)),
                                border: Border.fromBorderSide(BorderSide(
                                  color: colorTheme.primaryBrand,
                                  width: 1,
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
                        child: Icon(
                          Icons.check_rounded,
                          color: isTermAgreed ? colorTheme.grayscale100 : colorTheme.grayscale500,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text('개인정보 보호약관과 서비스 이용약관에 동의합니다.', style: textTheme.paragraph2.copyWith(color: colorTheme.grayscale600)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              isTermAgreed
                  ? DPButton(
                      onTap: widget.controller.nextPage,
                      child: const Text('계속'),
                    )
                  : DPButton.disabled(
                      child: const Text('계속'),
                    )
            ],
          ),
        ),
      ],
    );
  }
}
