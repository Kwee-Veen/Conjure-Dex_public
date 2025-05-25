import 'package:conjure_dex/colours.dart';
import 'package:conjure_dex/src/viewModels/navBar_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBottomNavigationBar extends StatelessWidget {

  AppBottomNavigationBar({super.key});

  final NavBarViewModel viewModel = Get.put(NavBarViewModel());

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Obx(() => BottomNavigationBar(
      currentIndex: viewModel.currentIndex.value,
      onTap: (index) {
        viewModel.currentIndex.value = index;
        Get.offAllNamed(viewModel.routes[index]);
      },
      selectedItemColor: isDarkMode ? AppColors.crystalLight : AppColors.crystal,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Browse",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: "Recent",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt),
          label: "Scan",
        ),
      ],
    ));
  }
}
