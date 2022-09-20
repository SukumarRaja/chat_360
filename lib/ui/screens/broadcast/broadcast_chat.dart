import 'package:chat360/ui/screens/pick_up/pick_up.dart';
import 'package:flutter/material.dart';

class BroadcastChat extends StatefulWidget {
  const BroadcastChat({Key? key}) : super(key: key);

  @override
  State<BroadcastChat> createState() => _BroadcastChatState();
}

class _BroadcastChatState extends State<BroadcastChat> {
  @override
  Widget build(BuildContext context) {
    // return PickupLayout(
    //     scaffold: Fiberchat.getNTPWrappedWidget(Consumer<List<BroadcastModel>>(
    //         builder: (context, broadcastList, _child) => WillPopScope(
    //           onWillPop: isgeneratingThumbnail == true
    //               ? () async {
    //             return Future.value(false);
    //           }
    //               : isemojiShowing == true
    //               ? () {
    //             setState(() {
    //               isemojiShowing = false;
    //               keyboardFocusNode.unfocus();
    //             });
    //             return Future.value(false);
    //           }
    //               : () async {
    //             setLastSeen(
    //               false,
    //             );
    //
    //             return Future.value(true);
    //           },
    //           child: Stack(
    //             children: [
    //               Scaffold(
    //                   key: _scaffold,
    //                   appBar: AppBar(
    //                     elevation:
    //                     DESIGN_TYPE == Themetype.messenger ? 0.4 : 1,
    //                     titleSpacing: 0,
    //                     leading: Container(
    //                       margin: EdgeInsets.only(right: 0),
    //                       width: 10,
    //                       child: IconButton(
    //                         icon: Icon(
    //                           Icons.arrow_back,
    //                           size: 24,
    //                           color: DESIGN_TYPE == Themetype.whatsapp
    //                               ? fiberchatWhite
    //                               : fiberchatBlack,
    //                         ),
    //                         onPressed: onWillPop,
    //                       ),
    //                     ),
    //                     backgroundColor: DESIGN_TYPE == Themetype.whatsapp
    //                         ? fiberchatDeepGreen
    //                         : fiberchatWhite,
    //                     title: InkWell(
    //                       onTap: () {
    //                         Navigator.push(
    //                             context,
    //                             new MaterialPageRoute(
    //                                 builder: (context) => BroadcastDetails(
    //                                     model: widget.model,
    //                                     prefs: widget.prefs,
    //                                     currentUserno: widget.currentUserno,
    //                                     broadcastID: widget.broadcastID)));
    //                       },
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.start,
    //                         children: [
    //                           Padding(
    //                               padding:
    //                               const EdgeInsets.fromLTRB(0, 7, 0, 7),
    //                               child: customCircleAvatarBroadcast(
    //                                   radius: 20,
    //                                   url: broadcastList
    //                                       .lastWhere((element) =>
    //                                   element.docmap[
    //                                   Dbkeys.broadcastID] ==
    //                                       widget.broadcastID)
    //                                       .docmap[
    //                                   Dbkeys.broadcastPHOTOURL])),
    //                           SizedBox(
    //                             width: 7,
    //                           ),
    //                           Expanded(
    //                             child: Column(
    //                               crossAxisAlignment:
    //                               CrossAxisAlignment.start,
    //                               children: [
    //                                 Text(
    //                                   broadcastList
    //                                       .lastWhere((element) =>
    //                                   element.docmap[
    //                                   Dbkeys.broadcastID] ==
    //                                       widget.broadcastID)
    //                                       .docmap[Dbkeys.broadcastNAME],
    //                                   maxLines: 1,
    //                                   overflow: TextOverflow.ellipsis,
    //                                   style: TextStyle(
    //                                       color: DESIGN_TYPE ==
    //                                           Themetype.whatsapp
    //                                           ? fiberchatWhite
    //                                           : fiberchatBlack,
    //                                       fontSize: 17.0,
    //                                       fontWeight: FontWeight.w500),
    //                                 ),
    //                                 SizedBox(
    //                                   height: 6,
    //                                 ),
    //                                 SizedBox(
    //                                   width: MediaQuery.of(context)
    //                                       .size
    //                                       .width /
    //                                       1.3,
    //                                   child: Text(
    //                                     getTranslated(this.context,
    //                                         'tapforbroadcastinfo'),
    //                                     overflow: TextOverflow.ellipsis,
    //                                     maxLines: 1,
    //                                     style: TextStyle(
    //                                         color: DESIGN_TYPE ==
    //                                             Themetype.whatsapp
    //                                             ? fiberchatWhite
    //                                             : fiberchatGrey,
    //                                         fontSize: 12,
    //                                         fontWeight: FontWeight.w400),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                   body: Stack(children: <Widget>[
    //                     new Container(
    //                       decoration: new BoxDecoration(
    //                         color: DESIGN_TYPE == Themetype.whatsapp
    //                             ? fiberchatChatbackground
    //                             : fiberchatWhite,
    //                         image: new DecorationImage(
    //                             image: AssetImage(
    //                                 "assets/images/background.png"),
    //                             fit: BoxFit.cover),
    //                       ),
    //                     ),
    //                     PageView(children: <Widget>[
    //                       Column(
    //                           mainAxisAlignment: MainAxisAlignment.end,
    //                           children: [
    //                             Expanded(
    //                                 child: buildMessagesUsingProvider(
    //                                     context)),
    //                             broadcastList
    //                                 .lastWhere((element) =>
    //                             element.docmap[
    //                             Dbkeys.broadcastID] ==
    //                                 widget.broadcastID)
    //                                 .docmap[
    //                             Dbkeys.broadcastMEMBERSLIST]
    //                                 .length >
    //                                 0
    //                             // ? Platform.isAndroid
    //                                 ? buildInputAndroid(
    //                                 context,
    //                                 isemojiShowing,
    //                                 refreshInput,
    //                                 _keyboardVisible,
    //                                 broadcastList)
    //                             // : buildInputIos(
    //                             //     context, broadcastList)
    //                                 : Container(
    //                               alignment: Alignment.center,
    //                               padding: EdgeInsets.fromLTRB(
    //                                   14, 7, 14, 7),
    //                               color: Colors.white,
    //                               height: 70,
    //                               width: MediaQuery.of(context)
    //                                   .size
    //                                   .width,
    //                               child: Text(
    //                                 getTranslated(
    //                                     this.context, 'norecp'),
    //                                 textAlign: TextAlign.center,
    //                                 style: TextStyle(height: 1.3),
    //                               ),
    //                             ),
    //                           ])
    //                     ]),
    //                   ])),
    //               buildLoadingThumbnail(),
    //             ],
    //           ),
    //         ))));
    return PickUpLayout(
        scaffold: Scaffold(),

    );
  }
}
