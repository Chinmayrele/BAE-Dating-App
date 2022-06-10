import 'package:bar_chat_dating_app/data/profile_card.dart';
import 'package:bar_chat_dating_app/data/tag_widget.dart';
import 'package:bar_chat_dating_app/models/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum Swipe { left, right, none }
var indexRR = 0;

class DragWidget extends StatefulWidget {
  const DragWidget({
    Key? key,
    required this.profile,
    required this.index,
    required this.swipeNotifier,
    required this.iLike,
    required this.intersectionOfLikes,
    required this.isViewed,
    required this.whoLikedMe,
  }) : super(key: key);
  final UserInfos profile;
  final int index;
  final ValueNotifier<Swipe> swipeNotifier;
  final List<dynamic> iLike;
  final List isViewed;
  final List whoLikedMe;
  final List intersectionOfLikes;

  @override
  State<DragWidget> createState() => _DragWidgetState();
}

class _DragWidgetState extends State<DragWidget> {
  ValueNotifier<Swipe> swipeNotifier = ValueNotifier(Swipe.none);
  List whoLikedMeOther = [];

  @override
  Widget build(BuildContext context) {
    indexRR = widget.index;
    // final result = Provider.of<InfoProviders>(context,listen: false);
    // result.changeIndex(widget.index);
    print('BUILD ENTERED IN DRAG WIDGET:>>>>>>>');
    return Center(
      child: Draggable<int>(
        // Data is the value this Draggable stores.
        data: widget.index,
        feedback: Material(
          color: Colors.transparent,
          child: ValueListenableBuilder(
            valueListenable: swipeNotifier,
            builder: (context, swipe, _) {
              return RotationTransition(
                turns: swipe != Swipe.none
                    ? swipe == Swipe.left
                        ? const AlwaysStoppedAnimation(-15 / 360)
                        : const AlwaysStoppedAnimation(15 / 360)
                    : const AlwaysStoppedAnimation(0),
                child: Stack(
                  children: [
                    ProfileCard(
                        profile: widget.profile,),
                    swipe != Swipe.none
                        ? swipe == Swipe.right
                            ? Positioned(
                                top: 40,
                                left: 20,
                                child: Transform.rotate(
                                  angle: 12,
                                  child: TagWidget(
                                    text: 'LIKE',
                                    color: Colors.green[400]!,
                                  ),
                                ),
                              )
                            : Positioned(
                                top: 50,
                                right: 24,
                                child: Transform.rotate(
                                  angle: -12,
                                  child: TagWidget(
                                    text: 'DISLIKE',
                                    color: Colors.red[400]!,
                                  ),
                                ),
                              )
                        : const SizedBox.shrink(),
                  ],
                ),
              );
            },
          ),
        ),
        onDragCompleted: () async {
          if (swipeNotifier.value == Swipe.right) {
            widget.isViewed.add(widget.profile.userId);
            widget.iLike.add(widget.profile.userId);
            // print("I LIKED LIST OBJECT BEFORE ASSIGNING: ${widget.iLike[0]}");
            for (var i in widget.iLike) {
              for (var j in widget.whoLikedMe) {
                if (i == j) {
                  widget.intersectionOfLikes.add(i);
                }
              }
            }
            // widget.tempILiked = widget.iLiked;
            // widget.tempILike.add(widget.profile.userId);
            whoLikedMeOther.add(FirebaseAuth.instance.currentUser!.uid);
            // widget.iLike
            //     .removeWhere((element) => !widget.whoLikedMe.contains(element));
            await FirebaseFirestore.instance
                .collection('profile')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({
              "isViewed": widget.isViewed,
              "iLike": widget.iLike,
              "intersectionLikes": widget.intersectionOfLikes,
            });
            await FirebaseFirestore.instance
                .collection('profile')
                .doc(widget.profile.userId)
                .update({
              "whoLikedMe": whoLikedMeOther,
            });
          }
          if (swipeNotifier.value == Swipe.left) {
            widget.isViewed.add(widget.profile.userId);
            await FirebaseFirestore.instance
                .collection('profile')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({
              "isViewed": widget.isViewed,
            });
          }
        },
        onDragUpdate: (DragUpdateDetails dragUpdateDetails) async {
          // When Draggable widget is dragged right
          if (dragUpdateDetails.delta.dx > 0 &&
              dragUpdateDetails.globalPosition.dx >
                  MediaQuery.of(context).size.width / 2) {
            swipeNotifier.value = Swipe.right;
          }
          // When Draggable widget is dragged left
          if (dragUpdateDetails.delta.dx < 0 &&
              dragUpdateDetails.globalPosition.dx <
                  MediaQuery.of(context).size.width / 2) {
            swipeNotifier.value = Swipe.left;
          }
        },
        childWhenDragging: Container(
          color: Colors.transparent,
        ),

        child: ProfileCard(
            profile: widget.profile),
      ),
    );
  }
}
