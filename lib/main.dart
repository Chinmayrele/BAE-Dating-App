import 'package:bar_chat_dating_app/data/call_page.dart';
import 'package:bar_chat_dating_app/providers/info_provider.dart';
import 'package:bar_chat_dating_app/screens/card_stack.dart';
import 'package:bar_chat_dating_app/screens/home_page_screen.dart';
import 'package:bar_chat_dating_app/screens/splash_screen.dart';
import 'package:bar_chat_dating_app/screens/start_screen.dart';
import 'package:bar_chat_dating_app/screens/subscription_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => InfoProviders(),
      child: MaterialApp(
        title: 'BAE Dating App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: Colors.black),
        home: const SplashScreen(),
        // home: const HomePageScreen(),
        routes: {
          // '/home_page': (context) => HomePage(),
          '/call_page': (context) => const CallPage(),
        },
      ),
    );
  }
}
