import 'package:get/get.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingBinding>(
      () => SettingBinding(),
    );
  }
}
