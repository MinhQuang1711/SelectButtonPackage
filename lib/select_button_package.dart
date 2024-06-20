library select_button_package;

/// A Calculator.
import 'package:flutter/material.dart';

import 'model/search_decoration.dart';
import 'model/search_item.dart';
import 'view/bottom_sheet.dart';

class SearchButton<T> extends StatefulWidget {
  const SearchButton({
    super.key,
    this.title,
    this.style,
    this.textAlign,
    this.decoration,
    this.initialValue,
    required this.onTap,
    required this.searchItems,
    this.searchDecoration,
    this.validator,
    this.onTapClearButton,
  });

  final Text? title;
  final TextStyle? style;
  final String? initialValue;
  final TextAlign? textAlign;
  final InputDecoration? decoration;
  final Function(SearchItem<T>) onTap;
  final SearchDecoration? searchDecoration;
  final List<SearchItem<T>> searchItems;
  final Function()? onTapClearButton;
  final String? Function(String?)? validator;

  @override
  State<SearchButton<T>> createState() => _SearchButtonState<T>();
}

class _SearchButtonState<T> extends State<SearchButton<T>> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
    super.initState();
  }

  void _onTap(SearchItem<T> val) {
    widget.onTap.call(val);
    _controller.text = val.displayLabel;
  }

  void _showBottomSheet() => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => SearchBottomSheet<T>(
          title: widget.title,
          searchDecoration: widget.searchDecoration,
          onTap: _onTap,
          searchItems: widget.searchItems,
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: _showBottomSheet,
      readOnly: true,
      style: widget.style,
      controller: _controller,
      decoration: widget.decoration,
      validator: widget.validator,
      initialValue: widget.initialValue,
      textAlign: widget.textAlign ?? TextAlign.start,
    );
  }
}
