import 'package:flutter/material.dart';

class SearchItem<T> {
  final T item;
  final Widget child;
  final String displayLabel;

  SearchItem({
    required this.item,
    required this.child,
    required this.displayLabel,
  });
}
