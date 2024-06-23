import 'package:flutter/material.dart';

class SearchItem<T> {
  final T item;
  final Widget? child;
  final String? searchValue;
  final String displayLabel;

  SearchItem({
    this.child,
    this.searchValue,
    required this.item,
    required this.displayLabel,
  });
}
