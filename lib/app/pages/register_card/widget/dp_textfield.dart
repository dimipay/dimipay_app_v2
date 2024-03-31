import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class DPTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode focusNode;
  final String? labelText;
  final String? hintText;
  final int? maxLength;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autoFocus;
  final List<TextInputFormatter>? inputFormatters;
  DPTextField({
    super.key,
    this.controller,
    FocusNode? focusNode,
    this.labelText,
    this.hintText,
    this.maxLength,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.autoFocus = false,
    this.inputFormatters,
  }) : focusNode = focusNode ?? FocusNode();

  @override
  State<DPTextField> createState() => _DPTextFieldState();
}

class _DPTextFieldState extends State<DPTextField> {
  @override
  void initState() {
    widget.focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      autofocus: widget.autoFocus,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 21, horizontal: 16),
        filled: true,
        fillColor: widget.focusNode.hasFocus ? DPColors.grayscale100 : DPColors.grayscale200,
        counterText: "",
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: DPColors.grayscale300,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: DPColors.primaryBrand,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: widget.labelText,
        labelStyle: DPTypography.itemDescription(color: DPColors.grayscale500),
        hintText: widget.hintText,
        hintStyle: DPTypography.description(color: DPColors.grayscale600),
      ),
      style: DPTypography.description(color: DPColors.grayscale1000),
      maxLength: widget.maxLength,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
    );
  }
}
