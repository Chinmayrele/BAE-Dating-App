import 'package:bar_chat_dating_app/global/show_modal_sheet.dart';
import 'package:bar_chat_dating_app/models/que_ans_info.dart';
import 'package:bar_chat_dating_app/models/user_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/color_constants.dart';
import '../providers/info_provider.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    Key? key,
    required this.profile,
    required this.queAnsDataResult,
  }) : super(key: key);
  final UserInfos profile;
  final QueAnsInfo queAnsDataResult;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  // late InfoProviders result;
  // late QueAnsInfo queAnsDataResult;
  // bool isLoadingQueAns = true;
  // @override
  // void initState() {
  //   result = Provider.of<InfoProviders>(context, listen: false);
  //   result.fetchQueAnsData(widget.profile.userId).then((value) {
  //     queAnsDataResult = value;
  //     setState(() {
  //       isLoadingQueAns = false;
  //     });
  //   });
  //   super.initState();
  // }

  @override
  void dispose() {
    // queAnsDataResult;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return
        // isLoadingQueAns
        //     ? const Center(
        //         child: CircularProgressIndicator(
        //           color: Colors.white,
        //         ),
        //       )
        //     :
        Container(
      height: size.height * 0.75,
      width: size.width * 0.87,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(
            color: Colors.red.withOpacity(0.3), blurRadius: 5, spreadRadius: 2),
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: Image.network(
                widget.profile.imageUrls[0],
                fit: BoxFit.cover,
                //   loadingBuilder:
                //       (BuildContext context, Widget child,
                //           ImageChunkEvent? loadingProgress) {
                // if (loadingProgress == null) return child;
                // return Center(
                //   child: CircularProgressIndicator(
                //     color: Colors.white,
                //     value: loadingProgress.expectedTotalBytes != null
                //         ? loadingProgress.cumulativeBytesLoaded /
                //             loadingProgress.expectedTotalBytes!
                //         : null,
                //   ),
                // );
              ),
            ),
            Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                ColorConstants.kBlack.withOpacity(0.25),
                ColorConstants.kBlack.withOpacity(0),
              ], end: Alignment.topCenter, begin: Alignment.bottomCenter)),
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
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.72,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      widget.profile.name,
                                      style: const TextStyle(
                                          color: ColorConstants.kWhite,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      widget.profile.age.toString(),
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
                              ],
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                showsheet(context, size,
                                    widget.queAnsDataResult, widget.profile);
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
  }
}
