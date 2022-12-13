import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../domain/restaurant/entities/restaurant_entity.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../route/navigation_util.dart';
import '../../../common/widget/common_widget.dart';
import '../../../restaurant_detail/ui/restaurant_detail_screen.dart';

class RestaurantItem extends StatelessWidget {
  final double width;
  final RestaurantEntity restaurantEntity;

  const RestaurantItem({@required this.width, @required this.restaurantEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            NavigationUtil.root.pushNamed(RestaurantDetailScreen.id,
                arguments: restaurantEntity);
          },
          child: Container(
            margin: const EdgeInsets.only(top: 18, bottom: 18),
            child: Row(
              children: <Widget>[
                Container(
                  decoration: boxDecoration(radius: 8, showShadow: true),
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  width: width / 7.2,
                  height: width / 7.2,
                  padding: EdgeInsets.all(width / 30),
                  child: Image.asset(
                    restaurantEntity.isOpen()
                        ? Assets.images.statusOpen.path
                        : Assets.images.statusClose.path,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            restaurantEntity.name,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const Divider(
          height: 0.5,
          color: appDividerColor,
        )
      ],
    );
  }
}
