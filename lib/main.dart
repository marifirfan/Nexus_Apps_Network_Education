import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:education_apps/provider/auth_provider.dart';
import 'package:education_apps/provider/imagepick_provider.dart';
import 'package:education_apps/app/modules/home/views/home_view.dart';
import 'package:education_apps/screen/login_screen.dart';
import 'package:education_apps/app/modules/course/views/course_view.dart';
import 'package:education_apps/app/modules/news/views/news_view_.dart';
import 'package:education_apps/app/modules/profile/views/profile_view.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// Handler untuk notifikasi background
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
  // Tambahkan logika untuk menampilkan notifikasi di sini jika perlu
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Mengatur handler untuk pesan background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Mengatur handler untuk pesan saat aplikasi pertama kali diluncurkan
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    // Logika untuk membuka halaman tertentu berdasarkan payload notifikasi
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProfider()),
        ChangeNotifierProvider(create: (_) => ImagePickProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return MainPage(); // Navigate to MainPage after login
              } else {
                return const LoginScreen(); // Show login screen if not logged in
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

// MainPage with Bottom Navigation Bar
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final RxInt _selectedIndex = 0.obs;

  final List<Widget> _pages = [
    HomeView(),
    CourseView(),
    NewsView(),
    ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
    _setupFirebaseMessaging();
  }

  Future<void> _setupFirebaseMessaging() async {
    // Mendengarkan pesan saat aplikasi berada di foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Message received in foreground: ${message.notification?.title}");
      // Tampilkan dialog notifikasi saat aplikasi aktif
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message.notification?.title ?? "Notifikasi"),
            content: Text(message.notification?.body ?? "Ada pesan baru!"),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Tutup'),
              ),
            ],
          );
        },
      );
    });

    // Mendengarkan token FCM
    String? token = await FirebaseMessaging.instance.getToken();
    print("FCM Registration Token: $token");

    // Mendengarkan perubahan token FCM
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      print("New FCM Registration Token: $newToken");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _pages[_selectedIndex.value]),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex.value,
        height: 60.0,
        color: const Color.fromARGB(255, 33, 150, 243),
        buttonBackgroundColor: Colors.blue,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.school, size: 30, color: Colors.white),
          Icon(Icons.newspaper, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        onTap: (index) => _selectedIndex.value = index,
      ),
    );
  }
}
