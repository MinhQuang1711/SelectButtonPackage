import 'dart:async';

import '../model/search_item.dart';

class SearchViewModel<T> {
  final _listSearchItemSubject = StreamController<List<SearchItem<T>>>();
  Stream<List<SearchItem<T>>> get listSearchItemStream =>
      _listSearchItemSubject.stream;

  void initItems(List<SearchItem<T>> items) {
    _listSearchItemSubject.sink.add(items);
  }

  void onChanged(String? val, List<SearchItem<T>> searchItems) {
    if (val == null || val.trim().isEmpty) {
      _listSearchItemSubject.sink.add(searchItems);
    } else {
      var result = searchItems
          .where((e) => (e.searchValue ?? e.displayLabel ?? "")
              .toLowerCase()
              .contains(val.trim().toLowerCase()))
          .toList();
      _listSearchItemSubject.sink.add(result);
    }
  }

  void disposeStream() {
    _listSearchItemSubject.close();
  }
}
