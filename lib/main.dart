import 'package:e_com/Admin/admin_home.dart';
import 'package:e_com/screens/bottom_nav.dart';
import 'package:e_com/screens/home_screen.dart';
import 'package:e_com/screens/login_screen.dart';
import 'package:e_com/screens/onboarding_screen.dart';
import 'package:e_com/screens/product_detail.dart';
import 'package:e_com/screens/signup_screen.dart';
// import 'package:e_com/services/constant.dart' as Stripe;
import 'package:e_com/services/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Admin/add_product.dart';
import 'Admin/admin_login.dart';
import 'firebase_options.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey= publishableKey;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Makes status bar transparent
        statusBarIconBrightness: Brightness.dark // Changes icons to white
    ),
  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home:OnboardingScreen()

      // ProductDetail(image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjHS1rhqO6WDzi-oE7i7lO77dllcYFbhDIQQ&s", name: "Wired", detail: "Im very good headphone", price: "22")
    );
  }
}

