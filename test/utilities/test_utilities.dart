import 'dart:ui';
import 'package:restaurant_management/generated/l10n.dart';

class TestUtilities {
  /// Initialize localization.
  static Future setupLocalization() async {
    await S.load(const Locale('en'));
  }
}
