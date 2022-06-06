import 'package:bar_chat_dating_app/screens/explore_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_tinder_clone_app/screens/account_screen.dart';
// import 'package:flutter_tinder_clone_app/screens/chat_screen.dart';
// import 'package:flutter_tinder_clone_app/screens/explore_screen.dart';
// import 'package:flutter_tinder_clone_app/screens/like_screen.dart';

import './account_screen.dart';
import './chat_screen.dart';
import './like_screen.dart';

/*
Title:HomePageScreen
Purpose:HomePageScreen
Created By:Kalpesh Khandla
*/

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int pageIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      // appBar: AppBarWidget(),
      body: getBody(),
      bottomNavigationBar: appBarWidget(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: const [
        ExploreScreen(),
        LikesScreen(),
        ChatScreen(),
        AccountScreen(),
      ],
    );
  }

  Widget appBarWidget() {
    List bottomItems = [
      pageIndex == 0 ? "assets/images/cmyk.png" : "assets/images/cmyk2.png",
      pageIndex == 1
          ? "assets/images/likes_active_icon.svg"
          : "assets/images/likes_icon.svg",
      pageIndex == 2
          ? "assets/images/chat_active_icon.svg"
          : "assets/images/chat_icon.svg",
      pageIndex == 3
          ? "assets/images/account_active_icon.svg"
          : "assets/images/account_icon.svg",
    ];
    // return AppBar(
    //   backgroundColor: Colors.black,
    //   elevation: 0,
    return Container(
      decoration: const BoxDecoration(color: Colors.white12),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 18, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(bottomItems.length, (index) {
          return IconButton(
            onPressed: () {
              setState(() {
                pageIndex = index;
              });
            },
            icon: index == 0
                ? Image.asset(bottomItems[index])
                : SvgPicture.asset(
                    bottomItems[index],
                  ),
          );
        }),
      ),
      // ),
    );
  }
}
