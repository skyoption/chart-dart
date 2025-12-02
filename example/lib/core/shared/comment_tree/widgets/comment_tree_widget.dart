import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'comment_child_widget.dart';
import 'root_comment_widget.dart';
import 'tree_theme_data.dart';

typedef AvatarWidgetBuilder<T> = PreferredSize Function(
  BuildContext context,
  T value,
);
typedef ContentBuilder<T> = Widget Function(BuildContext context, T value);

class CommentTreeWidget<R, C> extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = 'CommentTreeWidget';

  final R root;
  final List<C> replies;

  final ContentBuilder<R>? contentRoot;

  final ContentBuilder<C>? contentChild;
  final TreeThemeData treeThemeData;
  final Size sizeRoot, sizeChild;

  const CommentTreeWidget({
    super.key,
    required this.root,
    required this.replies,
    this.treeThemeData = const TreeThemeData(lineWidth: 1),
    this.contentRoot,
    this.contentChild,
    required this.sizeRoot,
    required this.sizeChild,
  });

  @override
  State<CommentTreeWidget<R, C>> createState() =>
      _CommentTreeWidgetState<R, C>();
}

class _CommentTreeWidgetState<R, C> extends State<CommentTreeWidget<R, C>> {
  @override
  Widget build(BuildContext context) {
    if (widget.replies.isEmpty) {
      return widget.contentRoot!(context, widget.root);
    }

    return Provider<TreeThemeData>.value(
      value: widget.treeThemeData,
      child: Column(
        children: [
          RootCommentWidget(
            sizeRoot: widget.sizeRoot,
            content: widget.contentRoot!(context, widget.root),
          ),
          ...widget.replies.map(
            (e) => CommentChildWidget(
              sizeRoot: widget.sizeRoot,
              sizeChild: widget.sizeChild,
              content: widget.contentChild!(context, e),
              isLast: widget.replies.indexOf(e) == (widget.replies.length - 1),
            ),
          )
        ],
      ),
    );
  }
}
