import 'package:flutter/material.dart';

class SearchDecoration {
  final String? hint;
  final double? width;
  final Widget? sufWidget;
  final Color? focusColor;
  final TextStyle? hintStyle;
  final Color? underLineColor;
  final EdgeInsets? conttentPadding;

  SearchDecoration(
      {this.hint,
      this.width,
      this.sufWidget,
      this.focusColor,
      this.hintStyle,
      this.underLineColor,
      this.conttentPadding});
}
