// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Untuk menangani file gambar dari galeri
import '../controllers/Profile_controller.dart';
import 'profile_settings_view.dart'; // Impor SettingsView

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  ProfileViewState createState() => ProfileViewState();
}

class ProfileViewState extends State<ProfileView> {
  final ProfileController controller = Get.put(ProfileController());
  File? profileImage; // Icon profile

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blue, // Warna biru untuk AppBar
      //   centerTitle: true,
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.settings),
      //       onPressed: () {
      //         Get.to(() => SettingsView()); // Navigasi ke halaman pengaturan
      //       },
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header dengan background biru dan foto profil
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 80, bottom: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        controller
                            .getImageFromGallery(); // Memanggil fungsi untuk memilih gambar
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            controller.selectedImagePath.value.isNotEmpty
                                ? FileImage(File(controller.selectedImagePath
                                    .value)) // Gambar dari galeri
                                : const NetworkImage(
                                    'https://www.example.com/profile_pic_url', // URL default gambar profil
                                  ) as ImageProvider,
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
                  const SizedBox(height: 10),
                  const Text(
                    'Muhammad Arif Irfan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Kelas 10 | SMAN 1 Jakarta',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Progress Belajar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Progress Belajar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: 0.7, // Progress kursus (70%)
                    backgroundColor: Colors.grey[300],
                    color: Colors.blue, // Warna biru untuk progress bar
                    minHeight: 8,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '70% selesai dari Kursus Matematika',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Kursus yang Diikuti
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kursus yang Diikuti',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(Icons.book, color: Colors.blue),
                    title: const Text('Matematika Dasar - Kelas 10'),
                    subtitle: const Text('Progress: 70%'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Fungsi menuju detail kursus
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.book, color: Colors.blue),
                    title: const Text('Fisika - Kelas 10'),
                    subtitle: const Text('Progress: 50%'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Fungsi menuju detail kursus
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.book, color: Colors.blue),
                    title: const Text('Kimia - Kelas 10'),
                    subtitle: const Text('Progress: 30%'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Fungsi menuju detail kursus
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Prestasi
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Prestasi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.emoji_events, color: Colors.amber),
                    title: Text('Juara 1 Olimpiade Matematika'),
                    subtitle: Text('Tahun 2023'),
                  ),
                  ListTile(
                    leading: Icon(Icons.emoji_events, color: Colors.amber),
                    title: Text('Finalis Lomba Sains Nasional'),
                    subtitle: Text('Tahun 2022'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Tombol Edit Profil
            // Tombol Edit Profil
            ElevatedButton(
              onPressed: () {
                Get.to(SettingsView());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.blue, // Warna biru untuk tombol Edit Profil
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Edit Profil',
                style: TextStyle(
                  color: Colors.white, // Warna teks Edit Profil
                ),
              ),
            ),
            const SizedBox(height: 20),
// Tombol Logout
            ElevatedButton(
              onPressed: () {
                // Fungsi logout
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Warna merah untuk tombol Logout
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white, // Warna teks Logout
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
