import 'package:bar_chat_dating_app/models/user_info.dart';
import 'package:bar_chat_dating_app/providers/info_provider.dart';
import 'package:bar_chat_dating_app/screens/chatting_screen.dart';
import 'package:bar_chat_dating_app/screens/subscription_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/color_constants.dart';
import '../data/chats_json.dart';

/*
Title:ChatScreen
Purpose:ChatScreen
Created By:Chinmay Rele
*/

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late InfoProviders result;
  late bool isSubscribed;
  late List<dynamic> intersectionUid;
  List<UserInfos> intersectionUserLikes = [];
  bool isLoading = true;
  // int indexR = 0;
  @override
  void initState() {
    print('INIT STATE OF CHAT SCREEN CALLED........');
    result = Provider.of<InfoProviders>(context, listen: false);
    result.fetchUSerProfileData().then((value) {
      intersectionUid = result.userInfo[0].intersectionLikes;
      isSubscribed = result.userInfo[0].isSubscribed;
      if (intersectionUid.isEmpty) {
        setState(() {
          isLoading = false;
        });
      }
      print('UID INTERSECTION: ${intersectionUid[0]}');
      for (int i = 0; i < intersectionUid.length; i++) {
        result.fetchSingleUserData(intersectionUid[i]).then((value) {
          print(value.email);
          intersectionUserLikes.add(value);
          setState(() {
            isLoading = false;
          });
        });
      }
      // print('INTERSECTION LIKES ID: ${intersectionUserLikes[0]}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: ColorConstants.kWhite,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : getBody(),
      ),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Messages",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.kPrimary,
                ),
              ),
              Container(
                height: 25,
                width: 1,
                decoration: BoxDecoration(
                    color: ColorConstants.kWhite.withOpacity(0.5)),
              ),
              Text(
                "Matches",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.kWhite.withOpacity(0.8)),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 0.8,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 0, right: 8),
          child: Container(
            height: 38,
            decoration: BoxDecoration(
                color: ColorConstants.kGrey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5)),
            child: TextField(
              style: TextStyle(color: ColorConstants.kWhite.withOpacity(0.7)),
              cursorColor: ColorConstants.kWhite.withOpacity(0.5),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: ColorConstants.kWhite.withOpacity(0.7),
                  ),
                  hintText: "Search 0 Matches",
                  hintStyle:
                      TextStyle(color: ColorConstants.kWhite.withOpacity(0.7))),
            ),
          ),
        ),
        const Divider(
          thickness: 0.8,
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Padding(
            //   padding: EdgeInsets.only(left: 15),
            //   child: Text(
            //     "New Matches",
            //     style: TextStyle(
            //         fontSize: 15,
            //         fontWeight: FontWeight.w500,
            //         color: ColorConstants.kPrimary),
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 15),
            //     child: Row(
            //         children: List.generate(chats_json.length, (index) {
            //       return Padding(
            //         padding: const EdgeInsets.only(right: 20),
            //         child: Column(
            //           children: <Widget>[
            //             SizedBox(
            //               width: 70,
            //               height: 70,
            //               child: Stack(
            //                 children: <Widget>[
            //                   chats_json[index]['story']
            //                       ? Container(
            //                           decoration: BoxDecoration(
            //                               shape: BoxShape.circle,
            //                               border: Border.all(
            //                                   color: ColorConstants.kPrimary,
            //                                   width: 3)),
            //                           child: Padding(
            //                             padding: const EdgeInsets.all(3.0),
            //                             child: Container(
            //                               width: 70,
            //                               height: 70,
            //                               decoration: BoxDecoration(
            //                                   shape: BoxShape.circle,
            //                                   image: DecorationImage(
            //                                       image: AssetImage(
            //                                           chats_json[index]['img']),
            //                                       fit: BoxFit.cover)),
            //                             ),
            //                           ),
            //                         )
            //                       : Container(
            //                           width: 65,
            //                           height: 65,
            //                           decoration: BoxDecoration(
            //                               shape: BoxShape.circle,
            //                               image: DecorationImage(
            //                                   image: AssetImage(
            //                                       chats_json[index]['img']),
            //                                   fit: BoxFit.cover)),
            //                         ),
            //                   chats_json[index]['online']
            //                       ? Positioned(
            //                           top: 48,
            //                           left: 52,
            //                           child: Container(
            //                             width: 20,
            //                             height: 20,
            //                             decoration: BoxDecoration(
            //                                 color: ColorConstants.kGreen,
            //                                 shape: BoxShape.circle,
            //                                 border: Border.all(
            //                                     color: ColorConstants.kWhite,
            //                                     width: 3)),
            //                           ),
            //                         )
            //                       : Container()
            //                 ],
            //               ),
            //             ),
            //             const SizedBox(
            //               height: 10,
            //             ),
            //             SizedBox(
            //               width: 70,
            //               child: Align(
            //                   child: Text(
            //                 chats_json[index]['name'],
            //                 overflow: TextOverflow.ellipsis,
            //               )),
            //             )
            //           ],
            //         ),
            //       );
            //     })),
            //   ),
            // ),
            const SizedBox(
              height: 30,
            ),
            intersectionUserLikes.isEmpty
                ? Column(
                    children: [
                      SizedBox(height: size.height * 0.25),
                      const Center(
                        child: Text(
                          'Looks like no one liked you!!!',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  )
                : !isSubscribed
                    ? const SubscriptionPage()
                    : Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          children: List.generate(intersectionUserLikes.length,
                              (index) {
                            // indexR = index;
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => ChattingScreen(
                                          chaterUser:
                                              intersectionUserLikes[index],
                                        )));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 4, right: 4, top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                    color: Colors.grey[900],
                                    border: Border.all(
                                      color: Colors.white24,
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 70,
                                      height: 70,
                                      child: Stack(
                                        children: <Widget>[
                                          // userMessages[index]['story']
                                          //     ? Container(
                                          //         decoration: BoxDecoration(
                                          //             shape: BoxShape.circle,
                                          //             border: Border.all(
                                          //                 color: ColorConstants
                                          //                     .kPrimary,
                                          //                 width: 3)),
                                          //         child: Padding(
                                          //           padding:
                                          //               const EdgeInsets.all(3.0),
                                          //           child: Container(
                                          //             width: 70,
                                          //             height: 70,
                                          //             decoration: BoxDecoration(
                                          //                 shape: BoxShape.circle,
                                          //                 image: DecorationImage(
                                          //                     image: NetworkImage(
                                          //                         intersectionUserLikes[
                                          //                                 index]
                                          //                             .imageUrls[0]
                                          //                         // userMessages[index]
                                          //                         //     ['img'],
                                          //                         ),
                                          //                     fit: BoxFit.cover)),
                                          //           ),
                                          //         ),
                                          //       )
                                          // :
                                          Container(
                                            width: 65,
                                            height: 65,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        intersectionUserLikes[
                                                                index]
                                                            .imageUrls[0]
                                                        // userMessages[index]
                                                        //     ['img'],
                                                        ),
                                                    fit: BoxFit.cover)),
                                          ),
                                          // userMessages[index]['online']
                                          //     ? Positioned(
                                          //         top: 48,
                                          //         left: 52,
                                          //         child: Container(
                                          //           width: 20,
                                          //           height: 20,
                                          //           decoration: BoxDecoration(
                                          //               color:
                                          //                   ColorConstants.kGreen,
                                          //               shape: BoxShape.circle,
                                          //               border: Border.all(
                                          //                   color: ColorConstants
                                          //                       .kWhite,
                                          //                   width: 3)),
                                          //         ),
                                          //       )
                                          //     : Container()
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          intersectionUserLikes[index].name,
                                          // userMessages[index]['name'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        // SizedBox(
                                        //   width: MediaQuery.of(context).size.width -
                                        //       135,
                                        //   child: Text(
                                        //     userMessages[index]['message'],
                                        //     style: TextStyle(
                                        //         fontSize: 15,
                                        //         color: ColorConstants.kWhite
                                        //             .withOpacity(0.8)),
                                        //     overflow: TextOverflow.ellipsis,
                                        //   ),
                                        // )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      )
          ],
        )
      ],
    );
  }
}
