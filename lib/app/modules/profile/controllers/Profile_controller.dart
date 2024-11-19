import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var selectedImagePath = ''.obs; // Observable path untuk gambar profil
  final ImagePicker picker = ImagePicker();

  get notificationsEnabled => null;

  get darkThemeEnabled => null;

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path; // Memperbarui path gambar
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }
}
