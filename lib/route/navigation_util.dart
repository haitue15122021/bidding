import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



class NavigationUtil {
  static final GlobalKey<NavigatorState> _rootNavigator = GlobalKey();
  static GlobalKey<NavigatorState> get rootKey => _rootNavigator;
  static NavigatorState get root => _rootNavigator.currentState;


  static final RouteObserver<PageRoute> contentObserver =
  RouteObserver<PageRoute>();

}

extension NavigatorStateExt on NavigatorState {
  void popUntilNamed(String name) {
    popUntil(
      !kIsWeb
          ? ModalRoute.withName(name)
          : ((route) {
        final routeName = (route.settings.arguments as Map)['routeName'];
        return route is ModalRoute &&
            !route.willHandlePopInternally &&
            name == routeName;
      }),
    );
  }
}
