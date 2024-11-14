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
  final bool hilightOnFocus;
  final void Function(String)? onChanged;
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
    this.hilightOnFocus = false,
    this.onChanged,
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
    DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
    DPTypography textTheme = Theme.of(context).extension<DPTypography>()!;
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      autofocus: widget.autoFocus,
      inputFormatters: widget.inputFormatters,
      cursorColor: colorTheme.primaryBrand,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 21, horizontal: 16),
        filled: true,
        fillColor: widget.focusNode.hasFocus && widget.hilightOnFocus ? colorTheme.grayscale100 : colorTheme.grayscale200,
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: colorTheme.grayscale300,
            width: 1,
          ),
        ),
        focusedBorder: widget.hilightOnFocus
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: colorTheme.primaryBrand,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              )
            : OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: colorTheme.grayscale300,
                  width: 1,
                ),
              ),
        labelText: widget.labelText,
        labelStyle: textTheme.itemDescription.copyWith(color: colorTheme.grayscale500),
        hintText: widget.hintText,
        hintStyle: textTheme.description.copyWith(color: colorTheme.grayscale600),
      ),
      style: textTheme.description.copyWith(color: colorTheme.grayscale1000),
      maxLength: widget.maxLength,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
    );
  }
}
