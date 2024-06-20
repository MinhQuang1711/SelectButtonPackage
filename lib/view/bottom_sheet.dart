import 'package:flutter/material.dart';

import '../const/box_decoration.dart';
import '../const/input_decoration.dart';
import '../const/padding.dart';
import '../const/view-model/search_view_model.dart';
import '../model/search_decoration.dart';
import '../model/search_item.dart';

class SearchBottomSheet<T> extends StatefulWidget {
  const SearchBottomSheet({
    super.key,
    this.title,
    required this.onTap,
    this.searchDecoration,
    required this.searchItems,
  });
  final Text? title;
  final Function(SearchItem<T>) onTap;
  final List<SearchItem<T>> searchItems;
  final SearchDecoration? searchDecoration;

  @override
  State<SearchBottomSheet<T>> createState() => _SearchBottomSheetState<T>();
}

class _SearchBottomSheetState<T> extends State<SearchBottomSheet<T>> {
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
          if (widget.title != null) widget.title!,
          _searchBar(widget.searchDecoration),
          const SizedBox(height: 20),
          _listView(_viewModel.listSearchItemStream, _onSelectedItem),
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

  TextField _searchBar(SearchDecoration? decoration) {
    return TextField(
      onChanged: _onChanged,
      decoration: searchInputDecoration(),
    );
  }

  Widget _listView(
      Stream<List<SearchItem<T>>> stream, Function(SearchItem<T>) onTap) {
    return Expanded(
      child: StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            var items = snapshot.data ?? [];
            return ListView.builder(
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => onTap.call(items[index]),
                child: items[index].child,
              ),
              itemCount: items.length,
            );
          }),
    );
  }
}
