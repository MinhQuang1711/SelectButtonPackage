import 'package:flutter/widgets.dart';
import 'package:select_button_package/widget/default_child.dart';

import '../model/search_item.dart';

class ListViewItem<T> extends StatelessWidget {
  const ListViewItem({
    super.key,
    this.emptyWidget,
    required this.onTap,
    required this.stream,
  });
  final Widget? emptyWidget;
  final Function(SearchItem<T>) onTap;
  final Stream<List<SearchItem<T>>> stream;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            var items = snapshot.data ?? [];
            return (items.isEmpty && emptyWidget != null)
                ? emptyWidget!
                : ListView.builder(
                    itemBuilder: (context, index) => GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => onTap.call(items[index]),
                      child: items[index].child ??
                          DefaultChild(item: items[index]),
                    ),
                    itemCount: items.length,
                  );
          }),
    );
  }
}
