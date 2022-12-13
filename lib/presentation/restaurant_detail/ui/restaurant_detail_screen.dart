import 'package:flutter/material.dart';

import '../../../domain/restaurant/entities/restaurant_entity.dart';
import '../../../generated/l10n.dart';
import '../../../route/navigation_util.dart';
import 'widget/time_open_item.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final RestaurantEntity restaurantEntity;
  const RestaurantDetailScreen({@required this.restaurantEntity});
  static const String id = 'RestaurantDetailScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        title: Text(
          restaurantEntity.name,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => NavigationUtil.root.pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20),
                child: Text(
                  S.current.openTime,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: restaurantEntity.openTimesInWeek.length,
                itemBuilder: (context, index) => TimeOpenItem(
                  timeOpen: restaurantEntity.openTimesInWeek[index],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
