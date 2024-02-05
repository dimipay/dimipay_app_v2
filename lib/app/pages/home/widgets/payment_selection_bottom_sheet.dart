import 'package:dimipay_design_kit/utils/dimipay_colors.dart';
import 'package:dimipay_design_kit/utils/dimipay_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../widgets/button.dart';
import '../../../widgets/divider.dart';

class PaymentSelectionBottomSheet extends StatefulWidget {
  const PaymentSelectionBottomSheet({Key? key}) : super(key: key);

  @override
  State<PaymentSelectionBottomSheet> createState() => _PaymentSelectionBottomSheetState();
}

class _PaymentSelectionBottomSheetState extends State<PaymentSelectionBottomSheet> {
  String selectedOption = 'X CHECK';

  void selectOption(String option) => setState(() => selectedOption = option);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 42),
      decoration: BoxDecoration(
        color: DPColors.grayscale100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const _TopIndicator(),
          const SizedBox(height: 20),
          const _Heading(text: '결제수단 선택'),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _PaymentOption(
                    title: 'X CHECK',
                    subtitle: '현대카드 (370*)',
                    assetPath: 'assets/images/hyundai.svg',
                    isSelected: selectedOption == 'X CHECK',
                    onSelect: () => selectOption('X CHECK'),
                  ),
                  _PaymentOption(
                    title: '지역농협 채움',
                    subtitle: '농협카드 (782*)',
                    assetPath: 'assets/images/nh.svg',
                    isSelected: selectedOption == '지역농협 채움',
                    onSelect: () => selectOption('지역농협 채움'),
                  ),
                  _PaymentOption(
                    title: 'LOCA Black',
                    subtitle: '롯데카드 (782*)',
                    assetPath: 'assets/images/lotte.svg',
                    isSelected: selectedOption == 'LOCA Black',
                    onSelect: () => selectOption('LOCA Black'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const DPDivider(),
          const SizedBox(height: 20),
          const _AddCardButton(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _TopIndicator extends StatelessWidget {
  const _TopIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        width: 36,
        height: 4,
        decoration: BoxDecoration(
          color: DPColors.grayscale300,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  final String text;

  const _Heading({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(text, style: DPTypography.header2(color: DPColors.grayscale1000)),
      ),
    );
  }
}

class _PaymentOption extends StatefulWidget {
  final String title;
  final String subtitle;
  final String assetPath;
  final bool isSelected;
  final VoidCallback onSelect;

  const _PaymentOption({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.assetPath,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<_PaymentOption> createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<_PaymentOption> {
  @override
  Widget build(BuildContext context) {
    return DPButton(
      onTap: widget.onSelect,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
        child: Row(
          children: [
            SvgPicture.asset(widget.assetPath, height: 40),
            const SizedBox(width: 12),
            Expanded(
              child: _CardDetail(title: widget.title, subtitle: widget.subtitle),
            ),
            const SizedBox(width: 12),
            if (widget.isSelected)
              const Icon(
                Icons.check_rounded,
                color: DPColors.primaryBrand,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}

class _CardDetail extends StatelessWidget {
  final String title;
  final String subtitle;

  const _CardDetail({Key? key, required this.title, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: DPTypography.itemTitle(color: DPColors.grayscale800)),
        const SizedBox(height: 4),
        Text(subtitle, style: DPTypography.itemDescription(color: DPColors.grayscale600)),
      ],
    );
  }
}

class _AddCardButton extends StatelessWidget {
  const _AddCardButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: DPColors.grayscale200,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(Icons.credit_card, size: 24, color: DPColors.grayscale600),
          ),
          const SizedBox(width: 12),
          Text('카드 추가하기', style: DPTypography.description(color: DPColors.grayscale600)),
        ],
      ),
    );
  }
}
