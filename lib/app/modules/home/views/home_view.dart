import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan judul dan deskripsi
            Container(
              height: 150,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(300),
                ),
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 35),
                  child: Text(
                    'Selamat Datang di Nexus Network Education.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            // Sekolah Favorit
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sekolah Favorit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(Icons.school, color: Colors.blue),
                    title: const Text('SMAN 1 Jakarta'),
                    subtitle: const Text('Kelas 10'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Fungsi
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.school, color: Colors.blue),
                    title: const Text('SMPN 2 Jakarta'),
                    subtitle: const Text('Kelas 9'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Fungsi
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Rekomendasi Kursus
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rekomendasi Kursus',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(Icons.book, color: Colors.blue),
                    title: const Text('Kursus Matematika Dasar'),
                    subtitle: const Text('Belajar dari nol!'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Fungsi
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.book, color: Colors.blue),
                    title: const Text('Kursus Fisika Menarik'),
                    subtitle: const Text(
                        'Keterapan fisika dalam kehidupan sehari-hari'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Fungsi
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Tombol Mulai Belajar
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Fungsi
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
                  'Mulai Belajar',
                  style: TextStyle(
                    color: Colors.white,
                  ),
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
