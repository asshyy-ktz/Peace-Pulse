import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peace_pulse/screens/home_screen.dart';
import 'package:peace_pulse/screens/splash_screen.dart';
import 'package:peace_pulse/utils/routes.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  //  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: const HomeScreen(),
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      initialRoute: MyRoutes.splashRoute,
      routes: {
        "/": (context) => const SplashScreen(),
        MyRoutes.homeRoute: (context) => const HomeScreen(),
      },
    );
  }
}
