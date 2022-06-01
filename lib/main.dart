import 'package:bar_chat_dating_app/providers/info_provider.dart';
import 'package:bar_chat_dating_app/screens/home_page_screen.dart';
import 'package:bar_chat_dating_app/screens/person_info.dart';
import 'package:bar_chat_dating_app/screens/que_screen.dart';
import 'package:bar_chat_dating_app/screens/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InfoProviders(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: Colors.black),
        //FOR SEEING LOGIN SCREEN ENTER 'STARTSCREEN()'
        home: StartScreen(),
        // home: const QueScreen(),
      ),
    );
  }
}
