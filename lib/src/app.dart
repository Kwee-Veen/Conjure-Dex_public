import 'package:conjure_dex/colours.dart';
import 'package:conjure_dex/src/views/cardDetails_view.dart';
import 'package:conjure_dex/src/views/recentCards_view.dart';
import 'package:conjure_dex/src/views/scan_view.dart';
import 'package:conjure_dex/src/widgets/bottomNavBar.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'views/browse_view.dart';
import 'settings/settings_controller.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    final initialUri = Uri.parse(Uri.base.toString());
    final initialPath = initialUri.path;

    return GetMaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
      ],
      onGenerateTitle: (BuildContext context) => 'Conjure Dex',
      theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          colorSchemeSeed: AppColors.whiteFeature,
          fontFamily: 'Cinzel'
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: AppColors.blackFeature,
        fontFamily: 'Cinzel',
      ),
      themeMode: Get.find<SettingsController>().themeMode,
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: '/', page: () => BrowseView()),
        GetPage(name: '/scan', page: () => ScanView()),
        GetPage(name: '/recent', page: () => RecentCardsView()),
        // Handles deep links from QR codes
        GetPage(
          name: '/open/:id',
          page: () => CardDetailsView(),
        ),
      ],

      // Using the overlay integrates the bottom nav bar into all pages
      builder: (context, child) {
        child = DevicePreview.appBuilder(context, child);
        final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

        return Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) => Container(
                color: backgroundColor,
                alignment: Alignment.center,
                child: ConstrainedBox(
                  // Caps the screen width at 700px or less. Crucial for PC displays, else everything looks horribly stretched
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Scaffold(
                    body: child,
                    bottomNavigationBar: AppBottomNavigationBar(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      onReady: () {
        // If starting on a deep link, pushes '/' into the back stack
        if (initialPath != '/' && initialPath.isNotEmpty) {
          Get.offAllNamed('/');
          Get.toNamed(initialPath);
        }
      },
    );
  }
}