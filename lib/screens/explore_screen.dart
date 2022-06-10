// import 'package:bar_chat_dating_app/providers/info_provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
// import 'package:flutter_tindercard/flutter_tindercard.dart';

// import '../common/color_constants.dart';
// import '../data/panel_widget.dart';
// import '../models/user_info.dart';

// /*
// Title:ExploreScreen
// Purpose:ExploreScreen
// Created By:Chinmay Rele
// */

// class ExploreScreen extends StatefulWidget {
//   const ExploreScreen({Key? key}) : super(key: key);
//   @override
//   _ExploreScreenState createState() => _ExploreScreenState();
// }

// class _ExploreScreenState extends State<ExploreScreen>
//     with TickerProviderStateMixin {
//   final PanelController panelController = PanelController();
//   CardController? controller;
//   // late InfoProviders userData;
//   late InfoProviders result;
//   late List<UserInfos> userProfileDataResult;
//   late List<UserInfos> usersDataResult;
//   bool isLoading = true;
//   List iLiked = [];
//   List tempILiked = [];
//   List isViewed = [];
//   List whoLikedMe = [];
//   List intersectionOfLikes = [];
//   // bool isFirstLoading = true;

//   List<UserInfos> itemsTemp = [];
//   int itemLength = 0;
//   // List itemsTemp = [];
//   // int itemLength = 0;
//   @override
//   void initState() {
//     super.initState();
//     result = Provider.of<InfoProviders>(context, listen: false);
//     result.fetchUSerProfileData().then((_) {
//       userProfileDataResult = result.userInfo;
//       iLiked = userProfileDataResult[0].iLiked;
//       isViewed = userProfileDataResult[0].isViewed;
//       whoLikedMe = userProfileDataResult[0].whoLikedMe;
//       intersectionOfLikes = userProfileDataResult[0].intersectionLikes;
//       print("LENGTH OF USERPROFILE DATA:  ${userProfileDataResult.length}");
//       print('EXPLORE SCREEN INIT STATE 1st PRINT');
//       print("GENDER CHOICE USER: ${userProfileDataResult[0].genderChoice}");
//       result
//           .fetchUsersData(
//         userProfileDataResult[0].genderChoice,
//         userProfileDataResult[0].latitude,
//         userProfileDataResult[0].longitude,
//       )
//           .then((_) {
//         print('FETCH USER DATA ENTER THEN VALUE');
//         if (result.usersData.isNotEmpty) {
//           print('LATITUDE: ${result.usersData[0].latitude}');
//           print('LONGITUDE: ${result.usersData[0].longitude}');
//         }
//         itemsTemp = result.usersData;
//         itemLength = result.usersData.length;
//         print("ITEM LENGTH: $itemLength");
//         setState(() {
//           isLoading = false;
//         });
//         print('888888888888888888888888');
//       });

//       // setState(() {
//       // itemsTemp = explore_json;
//       // itemLength = explore_json.length;
//     });
//   }

//   // var indexR = 0;
//   // String useId = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: (isLoading)
//           ? const Center(child: CircularProgressIndicator())
//           : SlidingUpPanel(
//               backdropTapClosesPanel: true,
//               color: Colors.black,
//               controller: panelController,
//               minHeight: 0,
//               maxHeight: MediaQuery.of(context).size.height * 0.5,
//               parallaxEnabled: true,
//               parallaxOffset: 0.5,
//               padding: const EdgeInsets.only(top: 15),
//               borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//               body: getBody(panelController),
//               panelBuilder: (controller) => PanelWidget(
//                 controller: controller,
//                 userProfileDataResult: itemLength == 0
//                     ? UserInfos(
//                         userId: '',
//                         name: 'name',
//                         email: 'email',
//                         phoneNo: 'phoneNo',
//                         gender: 'gender',
//                         genderChoice: 'genderChoice',
//                         iLiked: [],
//                         isViewed: [],
//                         whoLikedMe: [],
//                         intersectionLikes: [],
//                         latitude: 0.0,
//                         longitude: 0.0,
//                         age: 0,
//                         about: 'about',
//                         interest: 'interest',
//                         address: 'address',
//                         imageUrls: [])
//                     : itemsTemp[result.curIndex],
//                 // useId: useId,
//               ),
//             ),
//     );
//   }

//   Widget getBody(PanelController panelController) {
//     var size = MediaQuery.of(context).size;

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         // SizedBox(height: size.height * 0.06),
//         SizedBox(
//           width: MediaQuery.of(context).size.width * 0.85,
//           child: RichText(
//               textAlign: TextAlign.center,
//               text: const TextSpan(
//                   text: 'Find People Who Can ',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 19,
//                   ),
//                   children: [
//                     TextSpan(
//                       text: '𝓜𝓪𝓽𝓬𝓱',
//                       style: TextStyle(color: Colors.pink, fontSize: 22),
//                     ),
//                     TextSpan(
//                       text: ' With You',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 19),
//                     ),
//                   ])),
//         ),
//         SizedBox(
//           height: size.height * 0.75,
//           child: TinderSwapCard(
//             totalNum: itemLength,
//             maxWidth: MediaQuery.of(context).size.width * 0.95,
//             maxHeight: MediaQuery.of(context).size.height * 0.75,
//             minWidth: MediaQuery.of(context).size.width * 0.75,
//             minHeight: MediaQuery.of(context).size.height * 0.6,
//             cardBuilder: (context, index) {
//               // indexR = index;
//               // useId = itemsTemp[index].userId;
//               result.changeIndex(index);
//               return Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.red.withOpacity(0.3),
//                           blurRadius: 5,
//                           spreadRadius: 2),
//                     ]),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Stack(
//                     children: [
//                       Container(
//                         width: size.width,
//                         height: size.height,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                               image:
//                                   NetworkImage(itemsTemp[index].imageUrls[0]),
//                               fit: BoxFit.cover),
//                         ),
//                       ),
//                       Container(
//                         width: size.width,
//                         height: size.height,
//                         decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                                 colors: [
//                               ColorConstants.kBlack.withOpacity(0.25),
//                               ColorConstants.kBlack.withOpacity(0),
//                             ],
//                                 end: Alignment.topCenter,
//                                 begin: Alignment.bottomCenter)),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                     colors: [
//                                       Colors.red.withOpacity(0.55),
//                                       Colors.red.withOpacity(0)
//                                     ],
//                                     begin: Alignment.bottomCenter,
//                                     end: Alignment.topCenter),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(15),
//                                 child: Row(
//                                   children: [
//                                     SizedBox(
//                                       width: size.width * 0.72,
//                                       child: Column(
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 itemsTemp[index].name,
//                                                 style: const TextStyle(
//                                                     color:
//                                                         ColorConstants.kWhite,
//                                                     fontSize: 24,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                               const SizedBox(
//                                                 width: 10,
//                                               ),
//                                               Text(
//                                                 itemsTemp[index].age.toString(),
//                                                 style: const TextStyle(
//                                                   color: ColorConstants.kWhite,
//                                                   fontSize: 22,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           const SizedBox(height: 10),
//                                           Row(
//                                             children: [
//                                               Container(
//                                                 width: 10,
//                                                 height: 10,
//                                                 decoration: const BoxDecoration(
//                                                   color: ColorConstants.kGreen,
//                                                   shape: BoxShape.circle,
//                                                 ),
//                                               ),
//                                               const SizedBox(width: 10),
//                                               const Text(
//                                                 "Recently Active",
//                                                 style: TextStyle(
//                                                   color: ColorConstants.kWhite,
//                                                   fontSize: 16,
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                           const SizedBox(height: 15),
//                                           // Row(
//                                           //   children: List.generate(
//                                           //       itemsTemp[index]['likes']
//                                           //           .length, (indexLikes) {
//                                           //     if (indexLikes == 0) {
//                                           //       return Padding(
//                                           //         padding:
//                                           //             const EdgeInsets.only(
//                                           //                 right: 8),
//                                           //         child: Container(
//                                           //           decoration: BoxDecoration(
//                                           //               border: Border.all(
//                                           //                   color:
//                                           //                       ColorConstants
//                                           //                           .kWhite,
//                                           //                   width: 2),
//                                           //               borderRadius:
//                                           //                   BorderRadius
//                                           //                       .circular(30),
//                                           //               color: ColorConstants
//                                           //                   .kWhite
//                                           //                   .withOpacity(0.4)),
//                                           //           child: Padding(
//                                           //             padding:
//                                           //                 const EdgeInsets.only(
//                                           //                     top: 3,
//                                           //                     bottom: 3,
//                                           //                     left: 10,
//                                           //                     right: 10),
//                                           //             child: Text(
//                                           //               itemsTemp[index]
//                                           //                       ['likes']
//                                           //                   [indexLikes],
//                                           //               style: const TextStyle(
//                                           //                   color:
//                                           //                       ColorConstants
//                                           //                           .kWhite),
//                                           //             ),
//                                           //           ),
//                                           //         ),
//                                           //       );
//                                           //     }
//                                           //     return Padding(
//                                           //       padding: const EdgeInsets.only(
//                                           //           right: 8),
//                                           //       child: Container(
//                                           //         decoration: BoxDecoration(
//                                           //             borderRadius:
//                                           //                 BorderRadius.circular(
//                                           //                     30),
//                                           //             color: ColorConstants
//                                           //                 .kWhite
//                                           //                 .withOpacity(0.2)),
//                                           //         child: Padding(
//                                           //           padding:
//                                           //               const EdgeInsets.only(
//                                           //                   top: 3,
//                                           //                   bottom: 3,
//                                           //                   left: 10,
//                                           //                   right: 10),
//                                           //           child: Text(
//                                           //             itemsTemp[index]['likes']
//                                           //                 [indexLikes],
//                                           //             style: const TextStyle(
//                                           //                 color: ColorConstants
//                                           //                     .kWhite),
//                                           //           ),
//                                           //         ),
//                                           //       ),
//                                           //     );
//                                           //   }),
//                                           // )
//                                         ],
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: InkWell(
//                                         onTap: () {
//                                           setState(() {
//                                             if (panelController.isPanelOpen) {
//                                               panelController.close();
//                                             } else {
//                                               // result.changeIndex(index);
//                                               // indexR = index;
//                                               panelController.open();
//                                             }
//                                           });
//                                         },
//                                         child: SizedBox(
//                                           width: size.width * 0.2,
//                                           child: const Center(
//                                             child: Icon(
//                                               Icons.info,
//                                               color: ColorConstants.kWhite,
//                                               size: 28,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             },
//             cardController: controller,
//             swipeUpdateCallback:
//                 (DragUpdateDetails details, Alignment align) async {
//               /// Get swiping card's alignment
//               // if (align.x < -5) {
//               //   //Card is LEFT swiping

//               //   showDialog(
//               //       context: context,
//               //       builder: (context) {
//               //         Future.delayed(const Duration(seconds: 2), () {
//               //           Navigator.of(context).pop(true);
//               //         });
//               //         return Center(
//               //           child: SizedBox(
//               //               width: size.width * 0.5,
//               //               height: size.height * 0.2,
//               //               child: Image.asset(
//               //                 'assets/images/nope1_bae.png',
//               //                 fit: BoxFit.cover,
//               //               )),
//               //         );
//               //       });
//               //   isViewed.add(itemsTemp[result.curIndex].userId);
//               //   // indexR++;
//               //   // var v = result.curIndex;
//               //   // result.changeIndex(v++);
//               //   // result.curIndex;

//               //   await FirebaseFirestore.instance
//               //       .collection('profile')
//               //       .doc(FirebaseAuth.instance.currentUser!.uid)
//               //       .update({
//               //     "isViewed": isViewed,
//               //   });
//               //   // setState(() {});
//               //   //   .add({
//               //   // "isLiked": "No",
//               //   // "userId": itemsTemp[indexR].userId,
//               //   // });
//               //   panelController.close();
//               // } 
//                if (align.x > 5) {
//                 //Card is RIGHT swiping
//                 isViewed.add(itemsTemp[result.curIndex].userId);
//                 iLiked.add(itemsTemp[result.curIndex].userId);
//                 tempILiked = iLiked;
//                 whoLikedMe.add(FirebaseAuth.instance.currentUser!.uid);
//                 iLiked.removeWhere((element) => !whoLikedMe.contains(element));
//                 intersectionOfLikes = iLiked;
//                 showDialog(
//                     context: context,
//                     builder: (context) {
//                       Future.delayed(const Duration(seconds: 2), () {
//                         Navigator.of(context).pop(true);
//                       });
//                       return Center(
//                         child: SizedBox(
//                             width: size.width * 0.5,
//                             height: size.height * 0.2,
//                             child: Image.asset(
//                               'assets/images/like_bae.png',
//                               fit: BoxFit.cover,
//                             )),
//                       );
//                     });
//                 print('INDEX IF SWIPED RIGHT $result.curIndex');

//                 print("I LIKED VARIABLES STORED: ${tempILiked[0]}");
//                 await FirebaseFirestore.instance
//                     .collection('profile')
//                     .doc(FirebaseAuth.instance.currentUser!.uid)
//                     .update({
//                   "iLiked": tempILiked,
//                   "isViewed": isViewed,
//                   "intersectionLikes": intersectionOfLikes,
//                 });
//                 await FirebaseFirestore.instance
//                     .collection('profile')
//                     .doc(itemsTemp[result.curIndex].userId)
//                     .update({
//                   "whoLikedMe": whoLikedMe,
//                 });
//                 // indexR++;
//                 // var v = result.curIndex;
//                 // result.changeIndex(v++);
//                 // setState(() {});
//               }
//             },
//             swipeCompleteCallback:
//                 (CardSwipeOrientation orientation, int index) {
//               /// Get orientation & index of swiped card!
//               if (index == (itemsTemp.length)) {
//                 // showDialog(
//                 //     context: context,
//                 //     builder: (context) {
//                 //       // Future.delayed(const Duration(seconds: 2), () {
//                 //       //   Navigator.of(context).pop(true);
//                 //       // });
//                 //       return Center(
//                 //         child: SizedBox(
//                 //           width: size.width * 0.5,
//                 //           height: size.height * 0.2,
//                 //           child: const Text(
//                 //             'No More Profiles Found!!',
//                 //             style: TextStyle(
//                 //                 color: Colors.white,
//                 //                 fontWeight: FontWeight.bold),
//                 //           ),
//                 //         ),
//                 //       );
//                 //     });
//                 setState(() {
//                   const Center(
//                     child: Text(
//                       'No More Profiles Found!!',
//                       style: TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                   );
//                   // itemLength = itemsTemp.length - 1;
//                 });
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
