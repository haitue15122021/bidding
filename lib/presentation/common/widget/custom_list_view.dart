import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomListView extends StatefulWidget {
  final Function(int index) itemBuilder;
  final Function onRefresh;
  final Function onLoadMore;
  final bool canLoadMore;
  final int size;
  final RefreshController controller;

  const CustomListView({
    Key key,
    this.itemBuilder,
    this.onRefresh,
    this.onLoadMore,
    this.canLoadMore = true,
    this.size = 47,
    this.controller,
  }) : super(key: key);

  @override
  _CustomListViewState createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SmartRefresher(
      controller: widget.controller,
      onRefresh: widget.onRefresh,
      onLoading: widget.onLoadMore,
      footer: const ClassicFooter(),
      enablePullDown: true,
      enablePullUp: widget.canLoadMore && widget.size > 0,
      header: const ClassicHeader(),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.size,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) => widget.itemBuilder(index),
      ),
    );

  }

  @override
  bool get wantKeepAlive => true;
}
