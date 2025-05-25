import 'package:app_links/app_links.dart';
import 'package:conjure_dex/src/viewModels/browse_viewModel.dart';
import 'package:conjure_dex/src/viewModels/card_viewModel.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get/get.dart';
import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  // The below check is required to ensure the app is ready before calling the getAllCards() operation
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(SettingsController(SettingsService()));

  await Get.find<SettingsController>().loadSettings();

  Get.put(CardViewModel());
  Get.put(BrowseViewModel());
  usePathUrlStrategy();

  final appLinks = AppLinks();
  String? initialLink;
  try {
    initialLink = await appLinks.getInitialLinkString();
  } catch (e) {
    print('Error getting initial link: $e');
  }

  if (initialLink != null && initialLink.startsWith('/open/')) {
    final uri = Uri.parse(initialLink);
    final id = uri.pathSegments.last;
    runApp(MyApp(initialRoute: '/open/$id'));
  } else {
      runApp(
        DevicePreview(
          // Uncomment the below to enable DevicePreview
          // enabled: !kReleaseMode,
          enabled: false,
          builder: (context) => MyApp(initialRoute: '/'),
        ),
      );
    }
}