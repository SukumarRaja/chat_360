import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat360/ui/widgets/common_text.dart';
import 'package:flutter/material.dart';

import '../../../config/app_config.dart';
import '../../../utility/enum.dart';
import '../../themes/app_colors.dart';

class AudioCall extends StatefulWidget {
  const AudioCall({Key? key}) : super(key: key);

  @override
  State<AudioCall> createState() => _AudioCallState();
}

class _AudioCallState extends State<AudioCall> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return h > w && ((h / w) > 1.5)
        ? Scaffold(
            backgroundColor: AppConfig.designType == ThemeType.whatsapp
                ? AppColors.deepGreen
                : AppColors.deepGreen,
            body: Stack(
              children: [
                audioScreenPortrait(
                    context: context, status: "status", ispeermuted: true),
                panel(),
                toolbar(false,"status")
              ],
            ),
          )
        : Container();
  }

  audioScreenPortrait({
    required BuildContext context,
    String? status,
    bool? ispeermuted,
  }) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    if (status == 'rejected') {
      // _stopCallingSound();
    }
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            color: AppConfig.designType == ThemeType.messenger
                ? AppColors.deepGreen
                : AppColors.deepGreen,
            height: h / 4,
            width: w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 9),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.lock_rounded,
                      size: 17,
                      color: Colors.white38,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    CommonText(
                        text: "End to End Encryption",
                        // getTranslated(context, 'endtoendencryption'),
                        fontColor: Colors.white38,
                        fontWeight: FontWeight.w400),
                  ],
                ),
                // SizedBox(height: h / 35),
                SizedBox(
                  height: h / 9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 7),
                      SizedBox(
                        width: w / 1.1,
                        child: CommonText(
                          text: "Caller Name",
                          // widget.call.callerId == widget.currentUserUid
                          //     ? widget.call.receiverName!
                          //     : widget.call.callerName!,
                          maxLines: 1,
                          overFlow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w500,
                          fontColor: AppConfig.designType == ThemeType.whatsapp
                              ? AppColors.chattingWhite
                              : AppColors.chattingWhite,
                          fontSize: 27,
                        ),
                      ),
                      const SizedBox(height: 7),
                      CommonText(
                        text: "Caller Id",
                        // LimitConstants
                        //     .isRemovePhoneNumberFromCallingPageWhenOnCall ==
                        //     true
                        //     ? ""
                        //     : widget.call.callerId == widget.currentUserUid
                        //     ? widget.call.receiverId!
                        //     : widget.call.callerId!,
                        fontWeight: FontWeight.normal,
                        fontColor: AppConfig.designType == ThemeType.whatsapp
                            ? AppColors.chattingWhite.withOpacity(0.34)
                            : AppColors.chattingWhite.withOpacity(0.34),
                        fontSize: 15,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: h / 25),
                status == 'pickedup'
                    ? CommonText(
                        text: "00:12:23",
                        // "$hoursStr:$minutesStr:$secondsStr",
                        fontSize: 20.0,
                        fontColor: AppConfig.designType == ThemeType.whatsapp
                            ? Colors.green[300]
                            : Colors.green[300],
                        fontWeight: FontWeight.w600)
                    : CommonText(
                        text: "Missed Call",
                        // status == 'pickedup'
                        //     ? getTranslated(context, 'picked')
                        //     : status == 'nonetwork'
                        //     ? getTranslated(context, 'connecting')
                        //     : status == 'ringing' || status == 'missedcall'
                        //     ? getTranslated(context, 'calling')
                        //     : status == 'calling'
                        //     ? getTranslated(
                        //     context,
                        //     widget.call.receiverId ==
                        //         widget.currentUserUid
                        //         ? 'connecting'
                        //         : 'calling')
                        //     : status == 'pickedup'
                        //     ? getTranslated(context, 'oncall')
                        //     : status == 'ended'
                        //     ? getTranslated(
                        //     context, 'callended')
                        //     : status == 'rejected'
                        //     ? getTranslated(
                        //     context, 'callrejected')
                        //     : getTranslated(
                        //     context, 'plswait'),

                        fontWeight: FontWeight.w500,
                        fontColor: status == 'pickedup'
                            ? AppColors.lightGreen
                            : AppConfig.designType == ThemeType.whatsapp
                                ? AppColors.chattingWhite.withOpacity(0.5)
                                : AppColors.chattingWhite,
                        fontSize: 18,
                      ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Stack(
            children: [
              // widget.call.callerId == widget.currentUserUid
              //     ? widget.call.receiverPic == null ||
              //     widget.call.receiverPic == '' ||
              //     status == 'ended' ||
              //     status == 'rejected'
              status == "ended"
                  ? status == "ended"
                      ? Container(
                          height: w + (w / 11),
                          width: w,
                          color: Colors.white12,
                          child: Icon(
                            status == 'ended'
                                ? Icons.person_off
                                : status == 'rejected'
                                    ? Icons.call_end_rounded
                                    : Icons.person,
                            size: 140,
                            color: AppColors.deepGreen,
                          ),
                        )
                      : Stack(
                          children: [
                            Container(
                                height: w + (w / 11),
                                width: w,
                                color: Colors.white12,
                                child: CachedNetworkImage(
                                  imageUrl: "",
                                  // imageUrl: widget.call.callerId ==
                                  //     widget.currentUserUid
                                  //     ? widget.call.receiverPic!
                                  //     : widget.call.callerPic!,
                                  fit: BoxFit.cover,
                                  height: w + (w / 11),
                                  width: w,
                                  placeholder: (context, url) => Center(
                                      child: Container(
                                    height: w + (w / 11),
                                    width: w,
                                    color: Colors.white12,
                                    child: Icon(
                                      status == 'ended'
                                          ? Icons.person_off
                                          : status == 'rejected'
                                              ? Icons.call_end_rounded
                                              : Icons.person,
                                      size: 140,
                                      color: AppColors.deepGreen,
                                    ),
                                  )),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    height: w + (w / 11),
                                    width: w,
                                    color: Colors.white12,
                                    child: Icon(
                                      status == 'ended'
                                          ? Icons.person_off
                                          : status == 'rejected'
                                              ? Icons.call_end_rounded
                                              : Icons.person,
                                      size: 140,
                                      color: AppColors.deepGreen,
                                    ),
                                  ),
                                )),
                            Container(
                              height: w + (w / 11),
                              width: w,
                              color: Colors.black.withOpacity(0.18),
                            ),
                          ],
                        )
                  :
                  // widget.call.callerPic == null ||
                  //     widget.call.callerPic == '' ||
                  //     status == 'ended' ||
                  //     status == 'rejected'
                  status == "ended"
                      ? Container(
                          height: w + (w / 11),
                          width: w,
                          color: Colors.white12,
                          child: Icon(
                            status == 'ended'
                                ? Icons.person_off
                                : status == 'rejected'
                                    ? Icons.call_end_rounded
                                    : Icons.person,
                            size: 140,
                            color: AppColors.deepGreen,
                          ),
                        )
                      : Stack(
                          children: [
                            Container(
                                height: w + (w / 11),
                                width: w,
                                color: AppConfig.designType ==
                                        ThemeType.messenger
                                    ? AppColors.chattingGreen.withOpacity(0.6)
                                    : Colors.white12,
                                child: CachedNetworkImage(
                                  imageUrl: "",
                                  // imageUrl: widget.call.callerId ==
                                  //     widget.currentUserUid
                                  //     ? widget.call.receiverPic!
                                  //     : widget.call.callerPic!,
                                  fit: BoxFit.cover,
                                  height: w + (w / 11),
                                  width: w,
                                  placeholder: (context, url) => Center(
                                      child: Container(
                                    height: w + (w / 11),
                                    width: w,
                                    color: Colors.white12,
                                    child: Icon(
                                      status == 'ended'
                                          ? Icons.person_off
                                          : status == 'rejected'
                                              ? Icons.call_end_rounded
                                              : Icons.person,
                                      size: 140,
                                      color: AppColors.deepGreen,
                                    ),
                                  )),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    height: w + (w / 11),
                                    width: w,
                                    color: Colors.white12,
                                    child: Icon(
                                      status == 'ended'
                                          ? Icons.person_off
                                          : status == 'rejected'
                                              ? Icons.call_end_rounded
                                              : Icons.person,
                                      size: 140,
                                      color: AppColors.deepGreen,
                                    ),
                                  ),
                                )),
                            Container(
                              height: w + (w / 11),
                              width: w,
                              color: Colors.black.withOpacity(0.18),
                            ),
                          ],
                        ),
              // widget.call.callerId == widget.currentUserUid
              //     ? widget.call.receiverPic == null ||
              //             widget.call.receiverPic == '' ||
              //             status == 'ended' ||
              //             status == 'rejected'
              //         ? SizedBox()
              //         : Container(
              //             height: w + (w / 11),
              //             width: w,
              //             color: Colors.black.withOpacity(0.3),
              //           )
              //     : widget.call.callerPic == null ||
              //             widget.call.callerPic == '' ||
              //             status == 'ended' ||
              //             status == 'rejected'
              //         ? SizedBox()
              //         : Container(
              //             height: w + (w / 11),
              //             width: w,
              //             color: Colors.black.withOpacity(0.3),
              //           ),
              Positioned(
                  bottom: 20,
                  child: SizedBox(
                    width: w,
                    height: 20,
                    child: Center(
                      child: status == 'pickedup'
                          ? ispeermuted == true
                              ? CommonText(
                                  text: "Muted",
                                  // getTranslated(context, 'muted'),
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w600,
                                  fontColor:
                                      AppConfig.designType == ThemeType.whatsapp
                                          ? Colors.yellow
                                          : Colors.yellow,
                                  fontSize: 16,
                                )
                              : const SizedBox(
                                  height: 0,
                                )
                          : const SizedBox(
                              height: 0,
                            ),
                    ),
                  )),
            ],
          ),
          SizedBox(height: h / 6),
        ],
      ),
    );
  }

  panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            // itemCount: _infoStrings.length,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              // if (_infoStrings.isEmpty) {
              //   return SizedBox();
              // }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

   toolbar(
      bool isShowSpeaker,
      String? status,
      ) {
    // if (widget.role == ClientRole.Audience) {Container();}
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          status == 'ended' || status == 'rejected'
              ? SizedBox(height: 42, width: 42)
              : RawMaterialButton(
            onPressed: (){

            },
            shape: CircleBorder(),
            elevation: 2.0,
            // fillColor: muted ? Colors.blueAccent : Colors.white,
            fillColor:  Colors.white,
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              // muted ? Icons.mic_off : Icons.mic,
              Icons.mic,
              // color: muted ? Colors.white : Colors.blueAccent,
              color: Colors.blueAccent ,
              size: 22.0,
            ),
          ),
          RawMaterialButton(
            onPressed: () async {
              // setState(() {
              //   isalreadyendedcall =
              //   status == 'ended' || status == 'rejected' ? true : false;
              // });
              //
              // _onCallEnd(context);
            },
            child: Icon(
              status == 'ended' || status == 'rejected'
                  ? Icons.close
                  : Icons.call,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: status == 'ended' || status == 'rejected'
                ? Colors.black
                : Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          isShowSpeaker == true
              ? RawMaterialButton(
            onPressed: (){

            },
            child: Icon(
              // isspeaker
              //     ? Icons.volume_mute_rounded
              //     : Icons.volume_off_sharp,
              Icons.volume_mute_rounded,
              // color: isspeaker ? Colors.white : Colors.blueAccent,
              color:Colors.blueAccent,
              size: 22.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            // fillColor: isspeaker ? Colors.blueAccent : Colors.white,
            fillColor:  Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
              : SizedBox(height: 42, width: 42)
        ],
      ),
    );
  }
}
