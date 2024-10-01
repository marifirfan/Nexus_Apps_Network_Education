import 'package:education_apps/app/modules/course/views/course_view.dart';
import 'package:education_apps/app/modules/home/views/home_view.dart';
import 'package:education_apps/app/modules/library/views/library_view.dart';
import 'package:education_apps/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MainPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final RxInt _selectedIndex = 0.obs;

  final List<Widget> _pages = [
    HomeView(),
    CourseView(),
    LibraryView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _pages[_selectedIndex.value]),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex.value,
        height: 60.0,
        color: const Color.fromARGB(218, 40, 53, 236), // Warna latar belakang
        buttonBackgroundColor: Colors.blue, // Warna tombol
        backgroundColor:
            Colors.white, // Ubah warna latar belakang navbar menjadi putih
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.school, size: 30, color: Colors.white),
          Icon(Icons.chat, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        onTap: (index) => _selectedIndex.value = index,
      ),
    );
  }
}
