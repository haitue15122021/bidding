import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class LoadingListWidget extends StatelessWidget {
  final double heightItem;
  final double listSize;
  const LoadingListWidget({this.heightItem = 100, this.listSize = 10});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
          ),
          margin: const EdgeInsets.only(
            top: 10,
          ),
          child: Container(
            margin: const EdgeInsets.only(
              top: 15,
            ),
            height: heightItem,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
