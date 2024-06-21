import 'package:flutter/material.dart';
import 'package:select_button_package/widget/listview.dart';
import '../const/box_decoration.dart';
import '../const/padding.dart';
import '../view-model/search_view_model.dart';
import '../model/search_decoration.dart';
import '../model/search_item.dart';
import '../widget/search_bar.dart';

class CustomSelectButton<T> extends StatefulWidget {
  const CustomSelectButton({
    super.key,
    this.title,
    this.emptyWidget,
    required this.onTap,
    this.searchDecoration,
    required this.searchItems,
  });
  final Widget? title;
  final Widget? emptyWidget;
  final Function(SearchItem<T>) onTap;
  final List<SearchItem<T>> searchItems;
  final SearchDecoration? searchDecoration;

  @override
  State<CustomSelectButton<T>> createState() => _CustomSelectButtonState<T>();
}

class _CustomSelectButtonState<T> extends State<CustomSelectButton<T>> {
  final _viewModel = SearchViewModel<T>();
  @override
  void initState() {
    _viewModel.initItems(widget.searchItems);
    super.initState();
  }

  void _onChanged(String? val) => _viewModel.onChanged(val, widget.searchItems);
  void _onSelectedItem(SearchItem<T> val) {
    Navigator.pop(context);
    widget.onTap.call(val);
  }

  @override
  void dispose() {
    _viewModel.disposeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PADDING_22,
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BOX_DECORATION,
      child: Column(
        children: [
          _container(),
          const SizedBox(height: 15),
          if (widget.title != null) widget.title!,
          SearchBarSelect(
            onChanged: _onChanged,
            searchDecoration: widget.searchDecoration,
          ),
          const SizedBox(height: 20),
          ListViewItem(
            onTap: _onSelectedItem,
            emptyWidget: widget.emptyWidget,
            stream: _viewModel.listSearchItemStream,
          ),
        ],
      ),
    );
  }

  Container _container() {
    return Container(
      height: 4,
      width: 50,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(2)),
    );
  }
}
