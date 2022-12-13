import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DeviceUtils {
  static bool get isMobile =>
      !isTablet &&
          (defaultTargetPlatform == TargetPlatform.android ||
              defaultTargetPlatform == TargetPlatform.iOS);

  /// Logic is copied from https://pub.dev/packages/flutter_device_type
  /// If you're wondering why not use the package, it is because the package
  /// is using 'dart:ui' which is not really testable. It will take
  /// the size of monitor instead of phone when running widget test.
  static bool get isTablet {
    final windowSize = WidgetsBinding.instance.window;
    final data = MediaQueryData.fromWindow(windowSize);
    final devicePixelRatio = data.devicePixelRatio;
    final height = windowSize.physicalSize.height;
    final width = windowSize.physicalSize.width;
    final tabletSpec1 =
        devicePixelRatio < 2 && (width >= 1000 || height >= 1000);
    final tabletSpec2 =
        devicePixelRatio == 2 && (width >= 1920 || height >= 1920);
    return tabletSpec1 || tabletSpec2;
  }
}
