import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 'package:flutter/foundation.dart' provides top-level functions and classes,
// including 'kIsWeb', which is a constant to check if the app is running on the web.
import 'package:flutter/foundation.dart';

// 'dart:ui' gives you low-level access to the Flutter engine's services, like
// getting the physical screen size and device pixel ratio.
import 'dart:ui' as ui;

import 'package:viral_ai_personality_tests/screens/home_screen.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    // 'ScreenUtilInit' is the setup widget from the flutter_screenutil package.
    // It must be placed at the root of your app, before MaterialApp, so it can
    // provide screen-scaling information to all descendant widgets.
    return ScreenUtilInit(
      // 'designSize' is the most important property. It tells ScreenUtil the dimensions
      // (width, height) of the screen that you based your UI design on.
      // hhere i used custom to make it dynamic.
      designSize: getResponsiveSize(), // ✅ Only tweaks for web-based phones

      // 'minTextAdapt' ensures that text doesn't scale down to become unreadably small
      // on very narrow screens. It's a good accessibility practice.
      minTextAdapt: true,

      // 'splitScreenMode' enables support for devices that can run apps in
      splitScreenMode: true,


      builder: (context, child) {

        return MaterialApp(
          title: 'Viral AI Personality Tests',

          debugShowCheckedModeBanner: false,

          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true, // Enables the newer Material 3 design system.
          ),

          home: HomeScreen(),
        );
      },
    );
  }

  /// 📌 This function dynamically adjusts the 'designSize' for the ScreenUtil package.

  Size getResponsiveSize() {

    // - 'ui.window.physicalSize.width': The width of the screen in actual hardware pixels.
    //   (e.g., 1170 pixels on an iPhone 13 Pro).
    // - 'ui.window.devicePixelRatio': The number of hardware pixels for each logical pixel.
    //   (e.g., 3.0 on an iPhone 13 Pro).
    double deviceWidth = ui.window.physicalSize.width / ui.window.devicePixelRatio;

    // 'kIsWeb' is a special boolean that is 'true' only when the app is running in a web browser.
    // We check if we are on the web AND if the browser window's width is small (e.g., less than 600 logical pixels),
    // which is a common breakpoint for identifying a mobile-like view.
    if (kIsWeb && deviceWidth < 600) {
      // ✅ IF it's a mobile web browser:
      // We use the *actual browser width* as the design width. This makes the UI
      // perfectly match the browser window's dimensions, preventing weird scaling issues.
      // We keep a standard height (like 812, from an iPhone X) as it's less critical for responsive design.
      return Size(deviceWidth, 812);
    }

    // ✅ ELSE (for native mobile apps or large web browser windows):
    // We return a fixed, standard design size. '375x812' is a very common
    return const Size(375, 812);
  }
}