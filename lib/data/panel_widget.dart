import 'package:bar_chat_dating_app/models/que_ans_info.dart';
import 'package:bar_chat_dating_app/models/user_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/info_provider.dart';

class PanelWidget extends StatefulWidget {
  final ScrollController controller;
  final List<UserInfos> userProfileDataResult;
  final int index;
  const PanelWidget({
    Key? key,
    required this.controller,
    required this.userProfileDataResult,
    required this.index,
  }) : super(key: key);

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  buildMyBasics(String text) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              Colors.pink.withOpacity(0.4),
              Colors.pink.withOpacity(0.65)
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  late InfoProviders result;
  // late List<UserInfos> userProfileDataResult;
  late List<QueAnsInfo> queAnsDataResult;
  // bool isLoadingProfile = true;
  bool isLoadingQueAns = true;
  bool isTrue = true;

  @override
  void initState() {
    result = Provider.of<InfoProviders>(context, listen: false);
    // result.fetchUSerProfileData().then((value) {
    //   setState(() {
    //     userProfileDataResult = result.userInfo;
    //     print('888888888888888888888888');
    //     // print(userProfileDataResult.length);
    //     isLoadingProfile = false;
    //   });
    // });
    result.fetchQueAnsData().then((value) {
      setState(() {
        queAnsDataResult =
            Provider.of<InfoProviders>(context, listen: false).queAnsInfo;
        isLoadingQueAns = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoadingQueAns
        ? const CircularProgressIndicator()
        : ListView(
            padding: const EdgeInsets.all(0),
            controller: widget.controller,
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About Me',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.pink[300]!.withOpacity(0.4),
                                Colors.pink[300]!.withOpacity(0.6)
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                          // color: Colors.pink[200],
                          borderRadius: BorderRadius.circular(15)),
                      margin: const EdgeInsets.only(right: 15),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        // result
                        widget.userProfileDataResult[0].about,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'My Basics',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 15,
                      runSpacing: 8,
                      children: [
                        buildMyBasics(queAnsDataResult[0].vacationStatus),
                        buildMyBasics(queAnsDataResult[0].drinkStatus),
                        buildMyBasics(queAnsDataResult[0].exerciseStatus),
                        buildMyBasics(queAnsDataResult[0].heightStatus + ' cm'),
                        buildMyBasics(queAnsDataResult[0].nightStatus),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text('My Interests',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 15,
                      runSpacing: 8,
                      children: [
                        buildMyBasics(widget.userProfileDataResult[0].interest),
                      ],
                    ),
                    // IF IMAGE IS THERE
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          '${widget.userProfileDataResult[0].name.split(' ')[0]}\'s Location',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Icon(
                          Icons.location_on,
                          color: Color.fromARGB(255, 220, 87, 132),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    buildMyBasics(widget.userProfileDataResult[0].address),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
  }
}
