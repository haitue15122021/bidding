import 'package:flutter/material.dart';
import '../presentation/restaurant_detail/restaurant_detail_route.dart';
import '../presentation/restaurant_detail/ui/restaurant_detail_screen.dart';
import '../presentation/restaurant_list/restaurant_list_route.dart';
import '../presentation/restaurant_list/ui/restaurant_list_screen.dart';

class AppRouting {
  static MaterialPageRoute generateRoute(
    RouteSettings settings,
  ) {
    final routes = <String, WidgetBuilder>{
      RestaurantListScreen.id: (_) => RestaurantListRoute.route,
      RestaurantDetailScreen.id: (_) => RestaurantDetailRoute.route(
            arg: settings.arguments,
          )
    };
    final routeBuilder = routes[settings.name];

    return _NoAnimationMaterialPageRoute(
      builder: routeBuilder,
      settings: RouteSettings(
        name: settings.name,
      ),
    );
  }
}

class _NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  _NoAnimationMaterialPageRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
          builder: builder,
          maintainState: maintainState,
          settings: settings,
          fullscreenDialog: fullscreenDialog,
        );

  @override
  Widget buildTransitions(_, __, ___, Widget child) => child;
}
