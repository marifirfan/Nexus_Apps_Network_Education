import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_apps/app/modules/profile/controllers/Profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final ProfileController controller = Get.find<ProfileController>();

  // TextEditingController untuk menangani input teks
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Fetch data pengguna ketika widget diinisialisasi
  }

  // Fungsi untuk mengambil data pengguna dari Firestore
  void fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        setState(() {
          // Mengisi controller dengan data yang diambil dari Firestore
          usernameController.text = doc['name'] ?? '';
          emailController.text = doc['email'] ?? '';
          schoolController.text = doc['school'] ?? '';
        });
      }
    }
  }

  // Fungsi untuk menyimpan perubahan ke Firestore
  void saveChanges() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'name': usernameController.text,
        'email': emailController.text,
        'school': schoolController.text,
      });

      Get.snackbar(
        'Sukses',
        'Perubahan berhasil disimpan',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
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
                    backgroundImage: controller.selectedImagePath.value.isNotEmpty
                        ? FileImage(File(controller.selectedImagePath.value))
                        : const AssetImage('assets/default_profile.png'),
                    child: controller.selectedImagePath.value.isEmpty
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
                  controller.getImageFromGallery();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
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

              // Form untuk mengedit sekolah
              const Text(
                'Sekolah',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: schoolController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukkan nama sekolah',
                ),
              ),
              const SizedBox(height: 20),

              // Tombol Simpan
              Center(
                child: ElevatedButton(
                  onPressed: saveChanges, // Panggil fungsi untuk menyimpan perubahan
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
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
            ],
          ),
        ),
      ),
    );
  }
}
