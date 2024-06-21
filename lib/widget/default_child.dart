import 'package:flutter/material.dart';
import 'package:select_button_package/model/search_item.dart';

class DefaultChild<T> extends StatelessWidget {
  const DefaultChild({super.key, required this.item});
  final SearchItem<T> item; 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(12),
          child: Text(item.displayLabel),
        ),
      ],
    );
  }
}