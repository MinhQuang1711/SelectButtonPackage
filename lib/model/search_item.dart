import 'package:flutter/material.dart';

class SearchItem<T> {
  final T item;
  final Widget? child;
  final String displayLabel;

  SearchItem({
    this.child,
    required this.item, 
    required this.displayLabel,
  });
}
