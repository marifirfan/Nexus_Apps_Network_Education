import 'package:get/get.dart';

class LibraryBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LibraryBindings>(
      () => LibraryBindings(),
    );
  }
}
