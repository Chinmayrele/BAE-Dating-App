import 'package:bar_chat_dating_app/models/user_info.dart';
import 'package:bar_chat_dating_app/screens/subscription_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../data/drag_widget.dart';
import '../providers/info_provider.dart';

class CardsStackWidget extends StatefulWidget {
  const CardsStackWidget({Key? key}) : super(key: key);

  @override
  State<CardsStackWidget> createState() => _CardsStackWidgetState();
}

class _CardsStackWidgetState extends State<CardsStackWidget> {
  late InfoProviders result;
  late List<UserInfos> userProfileDataResult;
  late List<UserInfos> usersDataResult;
  bool isLoading = true;
  List<dynamic> iLike = [];
  List isViewed = [];
  List whoLikedMe = [];
  List intersectionOfLikes = [];
  final PanelController panelController = PanelController();

  List<UserInfos> dragabbleItems = [];
  int itemLength = 0;

  ValueNotifier<Swipe> swipeNotifier = ValueNotifier(Swipe.none);

  @override
  void initState() {
    result = Provider.of<InfoProviders>(context, listen: false);
    result.fetchUSerProfileData().then((_) {
      userProfileDataResult = result.userInfo;
      iLike = userProfileDataResult[0].iLike;
      // tempILike = userProfileDataResult[0].iLike;
      isViewed = userProfileDataResult[0].isViewed;
      whoLikedMe = userProfileDataResult[0].whoLikedMe;
      intersectionOfLikes = userProfileDataResult[0].intersectionLikes;
      print("LENGTH OF USERPROFILE DATA:  ${userProfileDataResult.length}");
      print('EXPLORE SCREEN INIT STATE 1st PRINT');
      print("GENDER CHOICE USER: ${userProfileDataResult[0].genderChoice}");
      result
          .fetchUsersData(
        userProfileDataResult[0].genderChoice,
        userProfileDataResult[0].latitude,
        userProfileDataResult[0].longitude,
      )
          .then((_) {
        print('FETCH USER DATA ENTER THEN VALUE');
        if (result.usersData.isNotEmpty) {
          print('LATITUDE: ${result.usersData[0].latitude}');
          print('LONGITUDE: ${result.usersData[0].longitude}');
        }
        dragabbleItems = result.usersData;
        itemLength = result.usersData.length;
        print("ITEM LENGTH: $itemLength");
        setState(() {
          isLoading = false;
        });
      });
      // setState(() {
      // itemsTemp = explore_json;
      // itemLength = explore_json.length;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.white,
                ))
              : getBody()),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        // SizedBox(height: size.height * 0.06),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                  text: 'Find People Who Can ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                  children: [
                    TextSpan(
                      text: '𝓜𝓪𝓽𝓬𝓱',
                      style: TextStyle(color: Colors.pink, fontSize: 22),
                    ),
                    TextSpan(
                      text: ' With You',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                  ])),
        ),
        SizedBox(height: size.height * 0.02),
        dragabbleItems.isEmpty
            ? Column(
                children: [
                  SizedBox(height: size.height * 0.34),
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: size.width * 0.95,
                    child: const Center(
                      child: Text(
                        'Looks Like we found no One around you!!!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    ),
                  ),
                ],
              )
            // const Center(
            //     child: Text(
            //       'Looks Like we found no One around you',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 24,
            //       ),
            //     ),
            //   )
            : Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ValueListenableBuilder(
                      valueListenable: swipeNotifier,
                      builder: (context, swipe, _) => Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: List.generate(dragabbleItems.length, (index) {
                          iLike.isEmpty
                              ? print('I LIKE LENGTH IS 0 RIGHT NOW')
                              : print(
                                  "I LIKED LIST OBJECT BEFORE ASSIGNING CARD STACK: ${iLike[0]}");
                          return index >= 4 &&
                                  !userProfileDataResult[0].isSubscribed
                              ? const SubscriptionPage()
                              : DragWidget(
                                  profile: dragabbleItems[index],
                                  index: index,
                                  swipeNotifier: swipeNotifier,
                                  iLike: iLike,
                                  isViewed: isViewed,
                                  whoLikedMe: whoLikedMe,
                                  intersectionOfLikes: intersectionOfLikes,
                                );
                        }),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    child: DragTarget<int>(
                      builder: (
                        BuildContext context,
                        List<dynamic> accepted,
                        List<dynamic> rejected,
                      ) {
                        return IgnorePointer(
                          child: Container(
                            height: 700.0,
                            width: 80.0,
                            color: Colors.transparent,
                          ),
                        );
                      },
                      onAccept: (int index) {
                        setState(() {
                          dragabbleItems.removeAt(index);
                        });
                      },
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: DragTarget<int>(
                      builder: (
                        BuildContext context,
                        List<dynamic> accepted,
                        List<dynamic> rejected,
                      ) {
                        return IgnorePointer(
                          child: Container(
                            height: 700.0,
                            width: 80.0,
                            color: Colors.transparent,
                          ),
                        );
                      },
                      onAccept: (int index) {
                        setState(() {
                          dragabbleItems.removeAt(index);
                        });
                      },
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
