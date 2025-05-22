import 'package:flutter/material.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class PaginatedListView<T> extends StatelessWidget {
  final List<T> items;
  final bool isLoadingMore;
  final bool hasMore;
  final ItemWidgetBuilder<T> itemBuilder;
  final VoidCallback onLoadMore;

  const PaginatedListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onLoadMore,
    required this.isLoadingMore,
    required this.hasMore,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: hasMore ? items.length + 1 : items.length,
      itemBuilder: (context, index) {
        if (index < items.length) {
          return itemBuilder(context, items[index]);
        } else {
          // Trigger load more
          if (!isLoadingMore) {
            onLoadMore();
          }
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
