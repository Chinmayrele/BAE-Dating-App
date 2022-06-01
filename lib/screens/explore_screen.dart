import 'package:bar_chat_dating_app/providers/info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

import '../common/color_constants.dart';
import '../data/explore_json.dart';
import '../data/icons.dart';
import '../data/panel_widget.dart';

/*
Title:ExploreScreen
Purpose:ExploreScreen
Created By:Kalpesh Khandla
*/

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with TickerProviderStateMixin {
  final PanelController panelController = PanelController();
  CardController? controller;

  List itemsTemp = [];
  int itemLength = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      itemsTemp = explore_json;
      itemLength = explore_json.length;
    });
  }

  var indexR = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorConstants.kWhite,
      // appBar: AppBar(title: Text('Find People Who Match With')),
      body: SlidingUpPanel(
        color: Colors.black,
        controller: panelController,
        minHeight: 0,
        maxHeight: MediaQuery.of(context).size.height * 0.5,
        parallaxEnabled: true,
        parallaxOffset: 0.5,padding: const EdgeInsets.only(top: 15),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        body: getBody(panelController),
        panelBuilder: (controller) => PanelWidget(
          controller: controller,
        ),
      ),
      // bottomSheet: getBottomSheet(),
    );
  }

  Widget getBody(PanelController panelController) {
    var size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SizedBox(height: size.height * 0.06),
        Row(
          children: [
            SizedBox(width: size.width * 0.18),
            const Text(
              'Find People Who Can ',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 19),
            ),
            Text(
              '𝓜𝓪𝓽𝓬𝓱',
              style: TextStyle(
                  color: Colors.red.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                  fontSize: 21),
            )
          ],
        ),
        const Text(
          'With You!',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
        ),
        SizedBox(
          height: size.height * 0.75,
          child: TinderSwapCard(
            totalNum: itemLength,
            maxWidth: MediaQuery.of(context).size.width * 0.95,
            maxHeight: MediaQuery.of(context).size.height * 0.75,
            minWidth: MediaQuery.of(context).size.width * 0.75,
            minHeight: MediaQuery.of(context).size.height * 0.6,
            cardBuilder: (context, index) {
              indexR = index;

              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.red.withOpacity(0.3),
                          blurRadius: 5,
                          spreadRadius: 2),
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      Container(
                        width: size.width,
                        height: size.height,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(itemsTemp[index]['img']),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        width: size.width,
                        height: size.height,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                              ColorConstants.kBlack.withOpacity(0.25),
                              ColorConstants.kBlack.withOpacity(0),
                            ],
                                end: Alignment.topCenter,
                                begin: Alignment.bottomCenter)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.red.withOpacity(0.55),
                                      Colors.red.withOpacity(0)
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.72,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                itemsTemp[index]['name'],
                                                style: const TextStyle(
                                                    color:
                                                        ColorConstants.kWhite,
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                itemsTemp[index]['age'],
                                                style: const TextStyle(
                                                  color: ColorConstants.kWhite,
                                                  fontSize: 22,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                decoration: const BoxDecoration(
                                                  color: ColorConstants.kGreen,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              const Text(
                                                "Recently Active",
                                                style: TextStyle(
                                                  color: ColorConstants.kWhite,
                                                  fontSize: 16,
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            children: List.generate(
                                                itemsTemp[index]['likes']
                                                    .length, (indexLikes) {
                                              if (indexLikes == 0) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                ColorConstants
                                                                    .kWhite,
                                                            width: 2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: ColorConstants
                                                            .kWhite
                                                            .withOpacity(0.4)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 3,
                                                              bottom: 3,
                                                              left: 10,
                                                              right: 10),
                                                      child: Text(
                                                        itemsTemp[index]
                                                                ['likes']
                                                            [indexLikes],
                                                        style: const TextStyle(
                                                            color:
                                                                ColorConstants
                                                                    .kWhite),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: ColorConstants
                                                          .kWhite
                                                          .withOpacity(0.2)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 3,
                                                            bottom: 3,
                                                            left: 10,
                                                            right: 10),
                                                    child: Text(
                                                      itemsTemp[index]['likes']
                                                          [indexLikes],
                                                      style: const TextStyle(
                                                          color: ColorConstants
                                                              .kWhite),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            panelController.isPanelOpen
                                                ? panelController.close()
                                                : panelController.open();
                                          });
                                        },
                                        child: SizedBox(
                                          width: size.width * 0.2,
                                          child: const Center(
                                            child: Icon(
                                              Icons.info,
                                              color: ColorConstants.kWhite,
                                              size: 28,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            cardController: controller = CardController(),
            swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
              /// Get swiping card's alignment
              if (align.x < -4) {
                //Card is LEFT swiping
                showDialog(
                    context: context,
                    builder: (context) {
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.of(context).pop(true);
                      });
                      return Center(
                        child: SizedBox(
                            width: size.width * 0.5,
                            height: size.height * 0.2,
                            child: Image.asset(
                              'assets/images/nope1_bae.png',
                              fit: BoxFit.cover,
                            )),
                      );
                    });
              } else if (align.x > 4) {
                //Card is RIGHT swiping
                showDialog(
                    context: context,
                    builder: (context) {
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.of(context).pop(true);
                      });
                      return Center(
                        child: SizedBox(
                            width: size.width * 0.5,
                            height: size.height * 0.2,
                            child: Image.asset(
                              'assets/images/like_bae.png',
                              fit: BoxFit.cover,
                            )),
                      );
                    });
              }
            },
            swipeCompleteCallback:
                (CardSwipeOrientation orientation, int index) {
              /// Get orientation & index of swiped card!
              if (index == (itemsTemp.length - 1)) {
                setState(() {
                  itemLength = itemsTemp.length - 1;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget getBottomSheet() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 120,
      decoration: const BoxDecoration(color: ColorConstants.kWhite),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(item_icons.length, (index) {
            return Container(
              width: item_icons[index]['size'],
              height: item_icons[index]['size'],
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.kWhite,
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstants.kBlack.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 10,
                      // changes position of shadow
                    ),
                  ]),
              child: Center(
                child: SvgPicture.asset(
                  item_icons[index]['icon'],
                  width: item_icons[index]['icon_size'],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
