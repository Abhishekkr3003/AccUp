import 'Pages/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'Utils/themes.dart';
import 'Utils/routes.dart';
import 'Pages/HomePage.dart';
import 'Pages/homepageview.dart';
import 'Pages/SplashScreen.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initFirebaseSdk = Firebase.initializeApp();
  final _navigatorKey = new GlobalKey<NavigatorState>();

  Future<void> waitAndNavigate(User? user) async {
    await Future.delayed(Duration(seconds: 1), () {
      if (user == null) {
        print('User is currently signed out!');
        _navigatorKey.currentState!.pushReplacementNamed(MyRoutes.loginPage);
      } else {
        // Future.delayed(Duration(seconds: 5), () {});
        print('User is signed in!');
        _navigatorKey.currentState!
            .pushReplacementNamed(MyRoutes.homeScreenShower);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MyThemes.lightTheme(context),
      navigatorKey: _navigatorKey,
      darkTheme: MyThemes.darkTheme(context),
      home: HomeScreenViewer(),
      // home: FutureBuilder(
      //     future: _initFirebaseSdk,
      //     builder: (_, snapshot) {
      //       // if (snapshot.hasError) return ErrorScreen();

      //       if (snapshot.connectionState == ConnectionState.done) {
      //         // Assign listener after the SDK is initialized successfully
      //         FirebaseAuth.instance.authStateChanges().listen((User? user) {
      //           waitAndNavigate(user);
      //         });
      //       }
      //       return SplashScreen();
      //     }),
      routes: {
        MyRoutes.loginPage: (context) => LoginPage(),
        MyRoutes.homePage: (context) => HomePage(),
        MyRoutes.splashSceen: (context) => SplashScreen(),
        MyRoutes.homeScreenShower: (context) => HomeScreenViewer(),
        // MyRoutes.profilePage: (context) => ProfilePage(),
      },
    );
  }
}
