import 'package:get/get.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileBindings>(
      () => ProfileBindings(),
    );
  }
}
