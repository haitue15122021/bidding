import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nb_utils/nb_utils.dart' hide S;

import 'core/core.dart';
import 'generated/l10n.dart';
import 'presentation/restaurant_list/ui/restaurant_list_screen.dart';
import 'route/app_routing.dart';
import 'route/navigation_util.dart';
import 'utils/di/service_locator.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();

  await setupLocator();
  runApp(RestaurantManagementApp());

}

class RestaurantManagementApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.defaultTheme,
      navigatorKey: NavigationUtil.rootKey,
      onGenerateRoute: AppRouting.generateRoute,
      initialRoute: RestaurantListScreen.id,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}

