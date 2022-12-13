part of core;

class AppTheme {
  static ThemeData get defaultTheme => ThemeData(
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        primaryColor: appColorPrimary,
        primaryColorDark: appColorPrimary,
        errorColor: Colors.red,
        textTheme: _typography,
        fontFamily: GoogleFonts.nunito().fontFamily

      );


  static TextTheme get _typography => TextTheme(
        headline1: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: DeviceUtils.isMobile ? 26 : 44,
        ),
        headline2: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: DeviceUtils.isMobile ? 24 : 40,
        ),
        headline3: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: DeviceUtils.isMobile ? 22 : 32,
        ),
        headline4: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: DeviceUtils.isMobile ? 19 : 28,
        ),
        headline5: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: DeviceUtils.isMobile ? 16 : 20,
        ),
        headline6: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: DeviceUtils.isMobile ? 16 : 20,
        ),
        bodyText1: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: DeviceUtils.isMobile ? 18 : 28,
        ),
        bodyText2: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: DeviceUtils.isMobile ? 17 : 24,
        ),
      );
}
