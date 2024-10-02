import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/course_controller.dart';

class CourseView extends StatelessWidget {
  final CourseController controller = Get.put(CourseController());

  CourseView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Jumlah filter
      child: Scaffold(
        appBar: AppBar(
          title: const Text(''), // Kosongkan judul
          backgroundColor: Colors.blue,
          bottom: const TabBar(
            labelColor: Color.fromARGB(
                255, 255, 255, 255), // Color of the selected tab's text
            unselectedLabelColor: Color.fromARGB(255, 6, 0, 116),
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Semua'),
              Tab(text: 'Matematika'),
              Tab(text: 'Fisika')
            ],
          ),

          //searchbar
          flexibleSpace: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20), // Tambahkan padding top
              child: SizedBox(
                width: 300, // Atur lebar search bar
                height: 40, // Atur tinggi search bar
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari Kursus...',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(135, 255, 255, 255)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.search, color: Colors.blue),
                  ),
                  onChanged: (value) {
                    // Logic
                  },
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildCourseList(),
            _buildCourseList(filter: 'Matematika'), // Daftar kursus Matematika
            _buildCourseList(filter: 'Fisika'), // Daftar kursus Fisika
          ],
        ),
      ),
    );
  }

  Widget _buildCourseList({String? filter}) {
    // Daftar kursus (contoh data)
    final courses = [
      {
        'title': 'Kursus Matematika Dasar',
        'subtitle':
            'Belajar konsep dasar matematika dengan cara yang menyenangkan!',
        'imageUrl':
            'https://img.freepik.com/free-vector/hand-drawn-online-college-template-design_23-2150573429.jpg?w=740&t=st=1727770811~exp=1727771411~hmac=90792acb88b388a3d144b87a1cc455a7d5b7689b4afd1c87f4b9ebcdcf4d9893', // Ganti dengan URL gambar kursus
      },
      {
        'title': 'Kursus Fisika Menarik',
        'subtitle':
            'Keterapan fisika dalam kehidupan sehari-hari melalui video praktis.',
        'imageUrl':
            'https://img.freepik.com/free-vector/hand-drawn-online-college-template-design_23-2150573429.jpg?w=740&t=st=1727770811~exp=1727771411~hmac=90792acb88b388a3d144b87a1cc455a7d5b7689b4afd1c87f4b9ebcdcf4d9893', // Ganti dengan URL gambar kursus
      },
      {
        'title': 'Kursus Kimia Interaktif',
        'subtitle':
            'Pelajari kimia dengan cara yang interaktif dan mudah dipahami!',
        'imageUrl':
            'https://img.freepik.com/free-vector/hand-drawn-online-college-template-design_23-2150573429.jpg?w=740&t=st=1727770811~exp=1727771411~hmac=90792acb88b388a3d144b87a1cc455a7d5b7689b4afd1c87f4b9ebcdcf4d9893', // Ganti dengan URL gambar kursus
      },
    ];

    // Menampilkan daftar kursus berdasarkan filter
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        // Hanya tampilkan kursus yang sesuai dengan filter
        if (filter != null &&
            !courses[index]['title']
                .toString()
                .toLowerCase()
                .contains(filter.toLowerCase())) {
          return const SizedBox.shrink();
        }
        return _buildCourseCard(
          context,
          courses[index]['title']!,
          courses[index]['subtitle']!,
          courses[index]['imageUrl']!,
        );
      },
    );
  }

  Widget _buildCourseCard(
      BuildContext context, String title, String subtitle, String imageUrl) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          children: [
            Image.network(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Aksi untuk memulai kursus
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Mulai Kursus',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
