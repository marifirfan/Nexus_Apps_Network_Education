import 'package:get/get.dart';

class ProfileSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileSettingsBinding>(
      () => ProfileSettingsBinding(),
    );
  }
}
