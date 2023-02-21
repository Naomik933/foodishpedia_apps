import 'package:get/get.dart';

import '../controllers/favorit_controller.dart';

class FavoritBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoritController>(
      () => FavoritController(),
    );
  }
}
