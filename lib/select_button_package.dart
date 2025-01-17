library select_button_package;

/// A Calculator.
import 'package:flutter/material.dart';

import 'model/search_decoration.dart';
import 'model/search_item.dart';
import 'view/bottom_sheet.dart';

class CustomSelectButton<T> extends StatefulWidget {
  const CustomSelectButton({
    super.key,
    this.title,
    this.style,
    this.searchValue,
    this.hideSeletedItem,
    this.textAlign,
    this.decoration,
    this.initialValue,
    required this.onTap,
    required this.searchItems,
    this.searchDecoration,
    this.controller,
    this.validator,
    this.readOnly,
    this.emptyWidget,
    this.onTapClearButton,
  });

  final Widget? title;
  final TextStyle? style;
  final bool? readOnly;
  final Widget? emptyWidget;
  final String? initialValue;
  final String? searchValue;
  final TextAlign? textAlign;
  final bool? hideSeletedItem;
  final InputDecoration? decoration;
  final Function(SearchItem<T>) onTap;
  final SearchDecoration? searchDecoration;
  final List<SearchItem<T>> searchItems;
  final Function()? onTapClearButton;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  State<CustomSelectButton<T>> createState() => _CustomSelectButtonState<T>();
}

class _CustomSelectButtonState<T> extends State<CustomSelectButton<T>> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if (widget.controller != null) {
      _controller = widget.controller!;
    }

    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
    super.initState();
  }

  void _onTap(SearchItem<T> val) {
    widget.onTap.call(val);
    if (widget.hideSeletedItem != true) {
      _controller.text = val.displayLabel ?? val.searchValue ?? "";
    }
  }

  @override
  void didUpdateWidget(covariant CustomSelectButton<T> oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (oldWidget.initialValue != widget.initialValue) {
        _controller.text = widget.initialValue ?? '';
      }
    });

    super.didUpdateWidget(oldWidget);
  }

  void _showBottomSheet() {
    if (widget.readOnly != true) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => SearchBottomSheet<T>(
          title: widget.title,
          emptyWidget: widget.emptyWidget,
          searchDecoration: widget.searchDecoration,
          onTap: _onTap,
          searchItems: widget.searchItems,
        ),
      );
    }
  }

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
      textAlign: widget.textAlign ?? TextAlign.start,
    );
  }
}
