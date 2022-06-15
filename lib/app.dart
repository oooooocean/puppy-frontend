import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:frontend/components/comps/refresh_scaffold.dart';
import 'package:frontend/components/mixins/theme_mixin.dart';
import 'package:frontend/route/pages.dart';

/// The entry of the app
class App extends StatelessWidget with ThemeMixin {
  final String initRoute;

  App({Key? key, required this.initRoute}) : super(key: key) {
    _customLoading();
  }

  @override
  Widget build(BuildContext context) => refreshScaffold(
        child: GetMaterialApp(
            enableLog: const bool.fromEnvironment('dart.vm.product'),
            initialRoute: initRoute,
            getPages: appRoutes,
            builder: EasyLoading.init(),
            theme: themeData),
      );

  /// custom loading
  /// see https://pub.dev/packages/flutter_easyloading
  void _customLoading() {
    EasyLoading.instance
      ..userInteractions = false
      ..dismissOnTap = false
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Colors.grey
      ..indicatorColor = Colors.orange
      ..textColor = Colors.white
      ..indicatorType = EasyLoadingIndicatorType.circle;
  }

  /// theme
  ThemeData get themeData => ThemeData(
        iconTheme: const IconThemeData(color: kSecondaryTextColor),
        textTheme: const TextTheme(
            bodyMedium: TextStyle(color: kPrimaryTextColor), labelLarge: TextStyle(color: kPrimaryTextColor)),
        inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(color: kGreyColor),
            counterStyle: TextStyle(color: kGreyColor),
            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: kBorderColor)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: kGreyColor))),
        appBarTheme: const AppBarTheme(
            backgroundColor: kBackgroundColor,
            centerTitle: true,
            elevation: 1,
            titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: kPrimaryTextColor)),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                foregroundColor: MaterialStateProperty.all(kPrimaryTextColor))),
        scaffoldBackgroundColor: kBackgroundColor,
      );
}
