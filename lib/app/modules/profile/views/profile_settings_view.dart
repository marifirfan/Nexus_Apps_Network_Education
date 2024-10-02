import 'package:education_apps/app/modules/profile/controllers/Profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io'; // Untuk mengimpor File

class SettingsView extends StatelessWidget {
  final ProfileController controller =
      Get.find<ProfileController>(); // Mendapatkan instance controller

  // TextEditingController untuk menangani input teks
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pengaturan Profil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Gambar Profil
              Center(
                child: Obx(
                  () => CircleAvatar(
                    radius: 60,
                    backgroundImage: controller.selectedImagePath.value != ''
                        ? FileImage(File(controller.selectedImagePath.value))
                        : const AssetImage(
                            'assets/default_profile.png'), // Gambar default
                    child: controller.selectedImagePath.value == ''
                        ? const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 30,
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller
                      .getImageFromGallery(); // Memanggil fungsi untuk memilih gambar
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Ganti Foto Profil',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),

              // Form untuk mengedit nama pengguna
              const Text(
                'Nama Pengguna',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukkan nama pengguna',
                ),
              ),
              const SizedBox(height: 20),

              // Form untuk mengedit email
              const Text(
                'Email',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukkan email',
                ),
              ),
              const SizedBox(height: 20),

              // Tombol Simpan
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Simpan perubahan (misalnya, Anda bisa memanggil fungsi di controller untuk menyimpan data)
                    Get.snackbar(
                      'Sukses',
                      'Perubahan berhasil disimpan',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Simpan Perubahan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Tombol Logout
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Fungsi logout
                    Get.snackbar(
                      'Logout',
                      'Anda telah berhasil logout',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
