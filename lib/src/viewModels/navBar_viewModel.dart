import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NavBarViewModel extends GetxController {
  final currentIndex = 0.obs;
  final List<String> routes = ['/', '/recent', '/scan'];
}