import 'package:education_apps/app/modules/profile/views/profile_settings_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:education_apps/provider/auth_provider.dart';
import 'package:education_apps/provider/imagepick_provider.dart';
import 'package:education_apps/app/modules/home/views/home_view.dart';
import 'package:education_apps/screen/login_screen.dart';
import 'package:education_apps/app/modules/course/views/course_view.dart';
import 'package:education_apps/app/modules/news/views/news_view_.dart';
import 'package:education_apps/app/modules/profile/views/Profile_view.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// Handler for background notifications
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProfider()),
        ChangeNotifierProvider(create: (_) => ImagePickProvider()),
      ],
      child: GetMaterialApp( // Changed from MaterialApp to GetMaterialApp
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
    // Listen for messages while the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Message received in foreground: ${message.notification?.title}");
      // Show a dialog notification when the app is active
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message.notification?.title ?? "Notification"),
            content: Text(message.notification?.body ?? "You have a new message!"),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    });

    // Listen for FCM token
    String? token = await FirebaseMessaging.instance.getToken();
    print("FCM Registration Token: $token");

    // Listen for changes in FCM token
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
