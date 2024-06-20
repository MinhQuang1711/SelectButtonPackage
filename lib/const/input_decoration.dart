import 'package:flutter/material.dart';
import '../model/search_decoration.dart';

InputDecoration searchInputDecoration({
  SearchDecoration? decoration,
}) =>
    InputDecoration(
      isDense: true,
      hintText: decoration?.hint,
      hintStyle: decoration?.hintStyle,
      contentPadding: decoration?.conttentPadding,
      suffixIcon: decoration?.sufWidget ?? const Icon(Icons.search),
      border: underLineBorder(
        width: decoration?.width,
        color: decoration?.underLineColor,
      ),
      enabledBorder: underLineBorder(
        width: decoration?.width,
        color: decoration?.underLineColor,
      ),
      focusedBorder: underLineBorder(
        width: decoration?.width,
        color: decoration?.focusColor ?? decoration?.underLineColor,
      ),
      disabledBorder: underLineBorder(
        width: decoration?.width,
        color: decoration?.underLineColor,
      ),
    );
UnderlineInputBorder underLineBorder({Color? color, double? width}) =>
    UnderlineInputBorder(
      borderSide: BorderSide(
        width: width ?? 0.5,
        color: color ?? Colors.grey,
      ),
    );
