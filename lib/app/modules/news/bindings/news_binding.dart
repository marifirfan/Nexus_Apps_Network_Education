import 'package:get/get.dart';

class NewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsBinding>(
      () => NewsBinding(),
    );
  }
}
