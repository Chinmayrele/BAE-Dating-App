import 'package:bar_chat_dating_app/providers/info_provider.dart';
import 'package:bar_chat_dating_app/screens/card_stack.dart';
import 'package:bar_chat_dating_app/screens/home_page_screen.dart';
import 'package:bar_chat_dating_app/screens/splash_screen.dart';
import 'package:bar_chat_dating_app/screens/start_screen.dart';
import 'package:bar_chat_dating_app/screens/subscription_page.dart';
import 'package:bar_chat_dating_app/screens/trial.dart';
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
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: Colors.black),
        home: const SplashScreen(),
        // home: const HomePageScreen(),
      ),
    );
  }
}

setVisitingFlag() async {
  SharedPreferences sharedPreference = await SharedPreferences.getInstance();
  sharedPreference.setBool('alreadyVisitedUser', true);
}

getVisitingFlag() async {
  SharedPreferences sharePreference = await SharedPreferences.getInstance();
  bool alreadyVisited = sharePreference.getBool('alreadyVisitedUser') ?? false;
  return alreadyVisited;
}


// import 'package:bar_chat_dating_app/providers/info_provider.dart';
// import 'package:bar_chat_dating_app/screens/account_screen.dart';
// import 'package:bar_chat_dating_app/screens/card_stack.dart';
// import 'package:bar_chat_dating_app/screens/chat_screen.dart';
// import 'package:bar_chat_dating_app/screens/chating.dart';
// import 'package:bar_chat_dating_app/screens/chatting_screen.dart';
// import 'package:bar_chat_dating_app/screens/home_page_screen.dart';
// import 'package:bar_chat_dating_app/screens/person_info.dart';
// import 'package:bar_chat_dating_app/screens/phone_login.dart';
// import 'package:bar_chat_dating_app/screens/que_screen.dart';
// import 'package:bar_chat_dating_app/screens/start_screen.dart';
// import 'package:bar_chat_dating_app/screens/trial.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => InfoProviders(),
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(scaffoldBackgroundColor: Colors.black),
//         //FOR SEEING LOGIN SCREEN ENTER 'STARTSCREEN()'
//         // home: const StartScreen(),
//         home: const CardsStackWidget(),
//       ),
//     );
//   }
// }
