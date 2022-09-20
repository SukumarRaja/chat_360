import 'package:chat360/ui/screens/pick_up/pick_up.dart';
import 'package:flutter/material.dart';

import '../../../config/app_config.dart';
import '../../../utility/enum.dart';
import '../../themes/app_colors.dart';
import '../../widgets/common_text.dart';
import '../../widgets/custom_circle_avatar.dart';

class AddContactBroadcast extends StatefulWidget {
  const AddContactBroadcast({Key? key}) : super(key: key);

  @override
  State<AddContactBroadcast> createState() => _AddContactBroadcastState();
}

class _AddContactBroadcastState extends State<AddContactBroadcast> {
  @override
  Widget build(BuildContext context) {
    bool list = false;
    bool selectList = false;
    bool searchContact = false;
    bool createBroadcast = false;
    bool length = false;

    // return PickupLayout(
    //     scaffold: Fiberchat.getNTPWrappedWidget(ScopedModel<DataModel>(
    //         model: widget.model!,
    //         child: ScopedModelDescendant<DataModel>(
    //             builder: (context, child, model) {
    //               return Consumer<AvailableContactsProvider>(
    //                   builder: (context, contactsProvider, _child) => Consumer<
    //                       List<BroadcastModel>>(
    //                       builder: (context, broadcastList, _child) => Scaffold(
    //                           key: _scaffold,
    //                           backgroundColor: fiberchatWhite,
    //                           appBar: AppBar(
    //                             elevation:
    //                             DESIGN_TYPE == Themetype.messenger ? 0.4 : 1,
    //                             leading: IconButton(
    //                               onPressed: () {
    //                                 Navigator.of(context).pop();
    //                               },
    //                               icon: Icon(
    //                                 Icons.arrow_back,
    //                                 size: 24,
    //                                 color: DESIGN_TYPE == Themetype.whatsapp
    //                                     ? fiberchatWhite
    //                                     : fiberchatBlack,
    //                               ),
    //                             ),
    //                             backgroundColor: DESIGN_TYPE == Themetype.whatsapp
    //                                 ? fiberchatDeepGreen
    //                                 : fiberchatWhite,
    //                             centerTitle: false,
    //                             title: _selectedList.length == 0
    //                                 ? Text(
    //                               getTranslated(
    //                                   this.context, 'selectcontacts'),
    //                               style: TextStyle(
    //                                 fontSize: 18,
    //                                 color: DESIGN_TYPE == Themetype.whatsapp
    //                                     ? fiberchatWhite
    //                                     : fiberchatBlack,
    //                               ),
    //                               textAlign: TextAlign.left,
    //                             )
    //                                 : Column(
    //                               crossAxisAlignment:
    //                               CrossAxisAlignment.start,
    //                               children: [
    //                                 Text(
    //                                   getTranslated(
    //                                       this.context, 'selectcontacts'),
    //                                   style: TextStyle(
    //                                     fontSize: 18,
    //                                     color:
    //                                     DESIGN_TYPE == Themetype.whatsapp
    //                                         ? fiberchatWhite
    //                                         : fiberchatBlack,
    //                                   ),
    //                                   textAlign: TextAlign.left,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 4,
    //                                 ),
    //                                 Text(
    //                                   widget.isAddingWhileCreatingBroadcast ==
    //                                       true
    //                                       ? '${_selectedList.length} / ${contactsProvider.joinedUserPhoneStringAsInServer.length}'
    //                                       : '${_selectedList.length} ${getTranslated(this.context, 'selected')}',
    //                                   style: TextStyle(
    //                                     fontSize: 12,
    //                                     color:
    //                                     DESIGN_TYPE == Themetype.whatsapp
    //                                         ? fiberchatWhite
    //                                         : fiberchatBlack,
    //                                   ),
    //                                   textAlign: TextAlign.left,
    //                                 ),
    //                               ],
    //                             ),
    //                             actions: <Widget>[
    //                               _selectedList.length == 0
    //                                   ? SizedBox()
    //                                   : IconButton(
    //                                 icon: Icon(
    //                                   Icons.check,
    //                                   color: DESIGN_TYPE == Themetype.whatsapp
    //                                       ? fiberchatWhite
    //                                       : fiberchatBlack,
    //                                 ),
    //                                 onPressed:
    //                                 widget.isAddingWhileCreatingBroadcast ==
    //                                     true
    //                                     ? () async {
    //                                   broadcastdesc.clear();
    //                                   broadcastname.clear();
    //                                   showModalBottomSheet(
    //                                       isScrollControlled: true,
    //                                       context: context,
    //                                       shape:
    //                                       RoundedRectangleBorder(
    //                                         borderRadius:
    //                                         BorderRadius.vertical(
    //                                             top: Radius
    //                                                 .circular(
    //                                                 25.0)),
    //                                       ),
    //                                       builder: (BuildContext
    //                                       context) {
    //                                         // return your layout
    //                                         var w = MediaQuery.of(
    //                                             context)
    //                                             .size
    //                                             .width;
    //                                         return Padding(
    //                                           padding: EdgeInsets.only(
    //                                               bottom: MediaQuery
    //                                                   .of(context)
    //                                                   .viewInsets
    //                                                   .bottom),
    //                                           child: Container(
    //                                               padding:
    //                                               EdgeInsets
    //                                                   .all(16),
    //                                               height: MediaQuery.of(
    //                                                   context)
    //                                                   .size
    //                                                   .height /
    //                                                   2.2,
    //                                               child: Column(
    //                                                   mainAxisSize:
    //                                                   MainAxisSize
    //                                                       .min,
    //                                                   crossAxisAlignment:
    //                                                   CrossAxisAlignment
    //                                                       .stretch,
    //                                                   children: [
    //                                                     SizedBox(
    //                                                       height:
    //                                                       12,
    //                                                     ),
    //                                                     SizedBox(
    //                                                       height: 3,
    //                                                     ),
    //                                                     Padding(
    //                                                       padding: const EdgeInsets
    //                                                           .only(
    //                                                           left:
    //                                                           7),
    //                                                       child:
    //                                                       Text(
    //                                                         getTranslated(
    //                                                             this.context,
    //                                                             'setbroadcastdetails'),
    //                                                         textAlign:
    //                                                         TextAlign.left,
    //                                                         style: TextStyle(
    //                                                             fontWeight:
    //                                                             FontWeight.bold,
    //                                                             fontSize: 16.5),
    //                                                       ),
    //                                                     ),
    //                                                     SizedBox(
    //                                                       height:
    //                                                       10,
    //                                                     ),
    //                                                     Container(
    //                                                       margin: EdgeInsets
    //                                                           .only(
    //                                                           top: 10),
    //                                                       padding: EdgeInsets
    //                                                           .fromLTRB(
    //                                                           0,
    //                                                           0,
    //                                                           0,
    //                                                           0),
    //                                                       // height: 63,
    //                                                       height:
    //                                                       83,
    //                                                       width: w /
    //                                                           1.24,
    //                                                       child:
    //                                                       InpuTextBox(
    //                                                         controller:
    //                                                         broadcastname,
    //                                                         leftrightmargin:
    //                                                         0,
    //                                                         showIconboundary:
    //                                                         false,
    //                                                         boxcornerradius:
    //                                                         5.5,
    //                                                         boxheight:
    //                                                         50,
    //                                                         hinttext: getTranslated(
    //                                                             this.context,
    //                                                             'broadcastname'),
    //                                                         prefixIconbutton:
    //                                                         Icon(
    //                                                           Icons
    //                                                               .edit,
    //                                                           color: Colors
    //                                                               .grey
    //                                                               .withOpacity(0.5),
    //                                                         ),
    //                                                       ),
    //                                                     ),
    //                                                     Container(
    //                                                       margin: EdgeInsets
    //                                                           .only(
    //                                                           top: 10),
    //                                                       padding: EdgeInsets
    //                                                           .fromLTRB(
    //                                                           0,
    //                                                           0,
    //                                                           0,
    //                                                           0),
    //                                                       // height: 63,
    //                                                       height:
    //                                                       83,
    //                                                       width: w /
    //                                                           1.24,
    //                                                       child:
    //                                                       InpuTextBox(
    //                                                         maxLines:
    //                                                         1,
    //                                                         controller:
    //                                                         broadcastdesc,
    //                                                         leftrightmargin:
    //                                                         0,
    //                                                         showIconboundary:
    //                                                         false,
    //                                                         boxcornerradius:
    //                                                         5.5,
    //                                                         boxheight:
    //                                                         50,
    //                                                         hinttext: getTranslated(
    //                                                             this.context,
    //                                                             'broadcastdesc'),
    //                                                         prefixIconbutton:
    //                                                         Icon(
    //                                                           Icons
    //                                                               .message,
    //                                                           color: Colors
    //                                                               .grey
    //                                                               .withOpacity(0.5),
    //                                                         ),
    //                                                       ),
    //                                                     ),
    //                                                     SizedBox(
    //                                                       height: 6,
    //                                                     ),
    //                                                     myElevatedButton(
    //                                                         color:
    //                                                         fiberchatLightGreen,
    //                                                         child:
    //                                                         Padding(
    //                                                           padding: const EdgeInsets.fromLTRB(
    //                                                               10,
    //                                                               15,
    //                                                               10,
    //                                                               15),
    //                                                           child:
    //                                                           Text(
    //                                                             getTranslated(context,
    //                                                                 'createbroadcast'),
    //                                                             style:
    //                                                             TextStyle(color: Colors.white, fontSize: 18),
    //                                                           ),
    //                                                         ),
    //                                                         onPressed:
    //                                                             () async {
    //                                                           Navigator.of(_scaffold.currentContext!)
    //                                                               .pop();
    //                                                           List<String>
    //                                                           listusers =
    //                                                           [];
    //                                                           List<String>
    //                                                           listmembers =
    //                                                           [];
    //                                                           _selectedList
    //                                                               .forEach((element) {
    //                                                             listusers.add(element[Dbkeys.phone]);
    //                                                             listmembers.add(element[Dbkeys.phone]);
    //                                                           });
    //
    //                                                           DateTime
    //                                                           time =
    //                                                           DateTime.now();
    //                                                           DateTime
    //                                                           time2 =
    //                                                           DateTime.now().add(Duration(seconds: 1));
    //                                                           Map<String, dynamic>
    //                                                           broadcastdata =
    //                                                           {
    //                                                             Dbkeys.broadcastDESCRIPTION: broadcastdesc.text.isEmpty
    //                                                                 ? ''
    //                                                                 : broadcastdesc.text.trim(),
    //                                                             Dbkeys.broadcastCREATEDON:
    //                                                             time,
    //                                                             Dbkeys.broadcastCREATEDBY:
    //                                                             widget.currentUserNo,
    //                                                             Dbkeys.broadcastNAME: broadcastname.text.isEmpty
    //                                                                 ? 'Unnamed BroadCast'
    //                                                                 : broadcastname.text.trim(),
    //                                                             Dbkeys.broadcastADMINLIST:
    //                                                             [
    //                                                               widget.currentUserNo
    //                                                             ],
    //                                                             Dbkeys.broadcastID: widget.currentUserNo!.toString() +
    //                                                                 '--' +
    //                                                                 time.millisecondsSinceEpoch.toString(),
    //                                                             Dbkeys.broadcastMEMBERSLIST:
    //                                                             listmembers,
    //                                                             Dbkeys.broadcastLATESTMESSAGETIME:
    //                                                             time.millisecondsSinceEpoch,
    //                                                             Dbkeys.broadcastBLACKLISTED:
    //                                                             [],
    //                                                           };
    //
    //                                                           listmembers
    //                                                               .forEach((element) {
    //                                                             broadcastdata.putIfAbsent(element.toString(),
    //                                                                     () => time.millisecondsSinceEpoch);
    //
    //                                                             broadcastdata.putIfAbsent('$element-joinedOn',
    //                                                                     () => time.millisecondsSinceEpoch);
    //                                                           });
    //                                                           setStateIfMounted(
    //                                                                   () {
    //                                                                 iscreatingbroadcast =
    //                                                                 true;
    //                                                               });
    //                                                           await FirebaseFirestore
    //                                                               .instance
    //                                                               .collection(DbPaths.collectionbroadcasts)
    //                                                               .doc(widget.currentUserNo!.toString() + '--' + time.millisecondsSinceEpoch.toString())
    //                                                               .set(broadcastdata)
    //                                                               .then((value) async {
    //                                                             await FirebaseFirestore.instance.collection(DbPaths.collectionbroadcasts).doc(widget.currentUserNo!.toString() + '--' + time.millisecondsSinceEpoch.toString()).collection(DbPaths.collectionbroadcastsChats).doc(time2.millisecondsSinceEpoch.toString() + '--' + widget.currentUserNo!.toString()).set({
    //                                                               Dbkeys.broadcastmsgCONTENT: '',
    //                                                               Dbkeys.broadcastmsgLISToptional: listmembers,
    //                                                               Dbkeys.broadcastmsgTIME: time2.millisecondsSinceEpoch,
    //                                                               Dbkeys.broadcastmsgSENDBY: widget.currentUserNo,
    //                                                               Dbkeys.broadcastmsgISDELETED: false,
    //                                                               Dbkeys.broadcastmsgTYPE: Dbkeys.broadcastmsgTYPEnotificationAddedUser,
    //                                                             }).then((value) async {
    //                                                               Navigator.of(_scaffold.currentContext!).pop();
    //                                                             }).catchError((err) {
    //                                                               setStateIfMounted(() {
    //                                                                 iscreatingbroadcast = false;
    //                                                               });
    //
    //                                                               Fiberchat.toast('Error Creating Broadcast. $err');
    //                                                               print('Error Creating Broadcast. $err');
    //                                                             });
    //                                                           });
    //                                                         }),
    //                                                   ])),
    //                                         );
    //                                       });
    //                                 }
    //                                     : () async {
    //                                   // List<String> listusers = [];
    //                                   List<String> listmembers = [];
    //                                   _selectedList
    //                                       .forEach((element) {
    //                                     // listusers.add(element[Dbkeys.phone]);
    //                                     listmembers.add(
    //                                         element[Dbkeys.phone]);
    //                                     // listmembers
    //                                     //     .add(widget.currentUserNo!);
    //                                   });
    //                                   DateTime time =
    //                                   DateTime.now();
    //
    //                                   setStateIfMounted(() {
    //                                     iscreatingbroadcast = true;
    //                                   });
    //
    //                                   Map<String, dynamic> docmap =
    //                                   {
    //                                     Dbkeys.broadcastMEMBERSLIST:
    //                                     FieldValue.arrayUnion(
    //                                         listmembers)
    //                                   };
    //
    //                                   _selectedList
    //                                       .forEach((element) async {
    //                                     docmap.putIfAbsent(
    //                                         '${element[Dbkeys.phone]}-joinedOn',
    //                                             () => time
    //                                             .millisecondsSinceEpoch);
    //                                   });
    //                                   setStateIfMounted(() {});
    //                                   await FirebaseFirestore
    //                                       .instance
    //                                       .collection(DbPaths
    //                                       .collectionbroadcasts)
    //                                       .doc(widget.broadcastID)
    //                                       .update(docmap)
    //                                       .then((value) async {
    //                                     await FirebaseFirestore
    //                                         .instance
    //                                         .collection(DbPaths
    //                                         .collectionbroadcasts)
    //                                         .doc(widget
    //                                         .currentUserNo!
    //                                         .toString() +
    //                                         '--' +
    //                                         time.millisecondsSinceEpoch
    //                                             .toString())
    //                                         .collection(DbPaths
    //                                         .collectionbroadcastsChats)
    //                                         .doc(time
    //                                         .millisecondsSinceEpoch
    //                                         .toString() +
    //                                         '--' +
    //                                         widget
    //                                             .currentUserNo!
    //                                             .toString())
    //                                         .set({
    //                                       Dbkeys.broadcastmsgCONTENT:
    //                                       '',
    //                                       Dbkeys.broadcastmsgLISToptional:
    //                                       listmembers,
    //                                       Dbkeys.broadcastmsgTIME: time
    //                                           .millisecondsSinceEpoch,
    //                                       Dbkeys.broadcastmsgSENDBY:
    //                                       widget.currentUserNo,
    //                                       Dbkeys.broadcastmsgISDELETED:
    //                                       false,
    //                                       Dbkeys.broadcastmsgTYPE:
    //                                       Dbkeys
    //                                           .broadcastmsgTYPEnotificationAddedUser,
    //                                     }).then((value) async {
    //                                       Navigator.of(context)
    //                                           .pop();
    //                                     }).catchError((err) {
    //                                       setStateIfMounted(() {
    //                                         iscreatingbroadcast =
    //                                         false;
    //                                       });
    //
    //                                       Fiberchat.toast(
    //                                         getTranslated(context,
    //                                             'erroraddingbroadcast'),
    //                                       );
    //                                     });
    //                                   });
    //                                 },
    //                               )
    //                             ],
    //                           ),
    //                           bottomSheet: _selectedList.length == 0
    //                               ? SizedBox(
    //                             height: 0,
    //                             width: 0,
    //                           )
    //                               : Container(
    //                             padding: EdgeInsets.only(top: 6),
    //                             width: MediaQuery.of(context).size.width,
    //                             height: 97,
    //                             child: ListView.builder(
    //                                 scrollDirection: Axis.horizontal,
    //                                 itemCount: _selectedList.reversed
    //                                     .toList()
    //                                     .length,
    //                                 itemBuilder: (context, int i) {
    //                                   return Stack(
    //                                     children: [
    //                                       Container(
    //                                         width: 80,
    //                                         padding:
    //                                         const EdgeInsets.fromLTRB(
    //                                             11, 10, 12, 10),
    //                                         child: Column(
    //                                           children: [
    //                                             customCircleAvatar(
    //                                                 url: _selectedList
    //                                                     .reversed
    //                                                     .toList()[i]
    //                                                 [Dbkeys.photoUrl],
    //                                                 radius: 20),
    //                                             SizedBox(
    //                                               height: 7,
    //                                             ),
    //                                             Text(
    //                                               _selectedList.reversed
    //                                                   .toList()[i]
    //                                               [Dbkeys.nickname],
    //                                               maxLines: 1,
    //                                               overflow:
    //                                               TextOverflow.ellipsis,
    //                                             ),
    //                                           ],
    //                                         ),
    //                                       ),
    //                                       Positioned(
    //                                         right: 17,
    //                                         top: 5,
    //                                         child: new InkWell(
    //                                           onTap: () {
    //                                             setStateIfMounted(() {
    //                                               _selectedList.remove(
    //                                                   _selectedList.reversed
    //                                                       .toList()[i]);
    //                                             });
    //                                           },
    //                                           child: new Container(
    //                                             width: 20.0,
    //                                             height: 20.0,
    //                                             padding:
    //                                             const EdgeInsets.all(2.0),
    //                                             decoration: new BoxDecoration(
    //                                               shape: BoxShape.circle,
    //                                               color: Colors.black,
    //                                             ),
    //                                             child: Icon(
    //                                               Icons.close,
    //                                               size: 14,
    //                                               color: Colors.white,
    //                                             ),
    //                                           ), //............
    //                                         ),
    //                                       )
    //                                     ],
    //                                   );
    //                                 }),
    //                           ),
    //                           body: RefreshIndicator(
    //                               onRefresh: () {
    //                                 return contactsProvider.fetchContacts(context,
    //                                     model, widget.currentUserNo!, widget.prefs);
    //                               },
    //                               child: contactsProvider
    //                                   .searchingcontactsindatabase ==
    //                                   true ||
    //                                   iscreatingbroadcast == true
    //                                   ? loading()
    //                                   : contactsProvider
    //                                   .joinedUserPhoneStringAsInServer
    //                                   .length ==
    //                                   0
    //                                   ? ListView(shrinkWrap: true, children: [
    //                                 Padding(
    //                                     padding: EdgeInsets.only(
    //                                         top: MediaQuery.of(context)
    //                                             .size
    //                                             .height /
    //                                             2.5),
    //                                     child: Center(
    //                                       child: Text(
    //                                           getTranslated(context,
    //                                               'nosearchresult'),
    //                                           textAlign: TextAlign.center,
    //                                           style: TextStyle(
    //                                               fontSize: 18,
    //                                               color: fiberchatGrey)),
    //                                     ))
    //                               ])
    //                                   : Padding(
    //                                 padding: EdgeInsets.only(
    //                                     bottom: _selectedList.length == 0
    //                                         ? 0
    //                                         : 80),
    //                                 child: Stack(
    //                                   children: [
    //                                     FutureBuilder(
    //                                         future: Future.delayed(
    //                                             Duration(seconds: 2)),
    //                                         builder: (c, s) =>
    //                                         s.connectionState ==
    //                                             ConnectionState
    //                                                 .done
    //                                             ? Container(
    //                                           alignment:
    //                                           Alignment
    //                                               .topCenter,
    //                                           child: Padding(
    //                                             padding:
    //                                             EdgeInsets
    //                                                 .all(
    //                                                 30),
    //                                             child: Card(
    //                                               elevation:
    //                                               0.5,
    //                                               color: Colors
    //                                                   .grey[
    //                                               100],
    //                                               child:
    //                                               Container(
    //                                                   padding: EdgeInsets.fromLTRB(
    //                                                       8,
    //                                                       10,
    //                                                       8,
    //                                                       10),
    //                                                   child:
    //                                                   RichText(
    //                                                     textAlign:
    //                                                     TextAlign.center,
    //                                                     text:
    //                                                     TextSpan(
    //                                                       children: [
    //                                                         WidgetSpan(
    //                                                           child: Padding(
    //                                                             padding: const EdgeInsets.only(bottom: 2.5, right: 4),
    //                                                             child: Icon(
    //                                                               Icons.contact_page,
    //                                                               color: fiberchatLightGreen.withOpacity(0.7),
    //                                                               size: 14,
    //                                                             ),
    //                                                           ),
    //                                                         ),
    //                                                         TextSpan(
    //                                                             text: getTranslated(this.context, 'nosavedcontacts'),
    //                                                             // text:
    //                                                             //     'No Saved Contacts available for this task',
    //                                                             style: TextStyle(color: fiberchatLightGreen.withOpacity(0.7), height: 1.3, fontSize: 13, fontWeight: FontWeight.w400)),
    //                                                       ],
    //                                                     ),
    //                                                   )),
    //                                             ),
    //                                           ),
    //                                         )
    //                                             : Container(
    //                                           alignment:
    //                                           Alignment
    //                                               .topCenter,
    //                                           child: Padding(
    //                                               padding:
    //                                               EdgeInsets
    //                                                   .all(
    //                                                   30),
    //                                               child:
    //                                               CircularProgressIndicator(
    //                                                 valueColor:
    //                                                 AlwaysStoppedAnimation<Color>(
    //                                                     fiberchatBlue),
    //                                               )),
    //                                         )),
    //                                     ListView.builder(
    //                                       physics:
    //                                       AlwaysScrollableScrollPhysics(),
    //                                       padding: EdgeInsets.all(10),
    //                                       itemCount: contactsProvider
    //                                           .joinedUserPhoneStringAsInServer
    //                                           .length,
    //                                       itemBuilder: (context, idx) {
    //                                         String phone = contactsProvider
    //                                             .joinedUserPhoneStringAsInServer[
    //                                         idx]
    //                                             .phone;
    //                                         Widget? alreadyAddedUser = widget
    //                                             .isAddingWhileCreatingBroadcast ==
    //                                             true
    //                                             ? null
    //                                             : broadcastList
    //                                             .lastWhere((element) =>
    //                                         element.docmap[
    //                                         Dbkeys
    //                                             .broadcastID] ==
    //                                             widget
    //                                                 .broadcastID)
    //                                             .docmap[Dbkeys
    //                                             .broadcastMEMBERSLIST]
    //                                             .contains(phone)
    //                                             ? SizedBox()
    //                                             : null;
    //                                         return alreadyAddedUser ??
    //                                             FutureBuilder(
    //                                                 future:
    //                                                 contactsProvider
    //                                                     .getUserDoc(
    //                                                     phone),
    //                                                 builder: (BuildContext
    //                                                 context,
    //                                                     AsyncSnapshot<
    //                                                         DocumentSnapshot>
    //                                                     snapshot) {
    //                                                   if (snapshot
    //                                                       .hasData &&
    //                                                       snapshot.data!
    //                                                           .exists) {
    //                                                     DocumentSnapshot
    //                                                     user =
    //                                                     snapshot
    //                                                         .data!;
    //                                                     return Container(
    //                                                       color: Colors
    //                                                           .white,
    //                                                       child: Column(
    //                                                         children: [
    //                                                           ListTile(
    //                                                             leading:
    //                                                             customCircleAvatar(
    //                                                               url: user[
    //                                                               Dbkeys.photoUrl],
    //                                                               radius:
    //                                                               22.5,
    //                                                             ),
    //                                                             trailing:
    //                                                             Container(
    //                                                               decoration:
    //                                                               BoxDecoration(
    //                                                                 border: Border.all(
    //                                                                     color: fiberchatGrey,
    //                                                                     width: 1),
    //                                                                 borderRadius:
    //                                                                 BorderRadius.circular(5),
    //                                                               ),
    //                                                               child: _selectedList.lastIndexWhere((element) => element[Dbkeys.phone] == phone) >=
    //                                                                   0
    //                                                                   ? Icon(
    //                                                                 Icons.check,
    //                                                                 size: 19.0,
    //                                                                 color: fiberchatLightGreen,
    //                                                               )
    //                                                                   : Icon(
    //                                                                 null,
    //                                                                 size: 19.0,
    //                                                               ),
    //                                                             ),
    //                                                             title: Text(
    //                                                                 user[Dbkeys.nickname] ??
    //                                                                     '',
    //                                                                 style:
    //                                                                 TextStyle(color: fiberchatBlack)),
    //                                                             subtitle: Text(
    //                                                                 phone,
    //                                                                 style:
    //                                                                 TextStyle(color: fiberchatGrey)),
    //                                                             contentPadding: EdgeInsets.symmetric(
    //                                                                 horizontal:
    //                                                                 10.0,
    //                                                                 vertical:
    //                                                                 0.0),
    //                                                             onTap:
    //                                                                 () {
    //                                                               setStateIfMounted(
    //                                                                       () {
    //                                                                     if (_selectedList.lastIndexWhere((element) => element[Dbkeys.phone] == phone) >=
    //                                                                         0) {
    //                                                                       _selectedList.remove(snapshot.data!);
    //                                                                       setStateIfMounted(() {});
    //                                                                     } else {
    //                                                                       _selectedList.add(snapshot.data!);
    //                                                                       setStateIfMounted(() {});
    //                                                                     }
    //                                                                   });
    //                                                             },
    //                                                           ),
    //                                                           Divider()
    //                                                         ],
    //                                                       ),
    //                                                     );
    //                                                   }
    //                                                   return SizedBox();
    //                                                 });
    //                                       },
    //                                     ),
    //                                   ],
    //                                 ),
    //                               )))));
    //             }))));

    return PickUpLayout(
      scaffold: Scaffold(
        backgroundColor: AppColors.chattingWhite,
        appBar: AppBar(
          elevation: AppConfig.designType == ThemeType.messenger ? 0.4 : 1,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              size: 24,
              color: AppConfig.designType == ThemeType.whatsapp
                  ? AppColors.chattingWhite
                  : AppColors.chattingBlack,
            ),
          ),
          backgroundColor: AppConfig.designType == ThemeType.whatsapp
              ? AppColors.deepGreen
              : AppColors.chattingWhite,
          centerTitle: false,
          title:
              // selectedList.isEmpty
              list == false
                  ? CommonText(
                      text: "Select Contact",
                      // getTranslated(this.context, 'selectcontacts'),

                      fontSize: 18,
                      fontColor: AppConfig.designType == ThemeType.whatsapp
                          ? AppColors.chattingWhite
                          : AppColors.chattingBlack,

                      textAlign: TextAlign.left,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: "Select Contact",
                          // getTranslated(this.context, 'selectcontacts'),

                          fontSize: 18,
                          fontColor: AppConfig.designType == ThemeType.whatsapp
                              ? AppColors.chattingWhite
                              : AppColors.chattingBlack,

                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        CommonText(
                          text: "0 Select",
                          // widget.isAddingWhileCreatingBroadcast == true
                          //     ? '${selectedList.length} / ${contactsProvider.joinedUserPhoneStringAsInServer.length}'
                          //     : '${selectedList.length} ${getTranslated(this.context, 'selected')}',

                          fontSize: 12,
                          fontColor: AppConfig.designType == ThemeType.whatsapp
                              ? AppColors.chattingWhite
                              : AppColors.chattingBlack,

                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
          actions: [
            // selectedList.isEmpty
            selectList == false
                ? const SizedBox()
                : IconButton(
                    icon: Icon(
                      Icons.check,
                      color: AppConfig.designType == ThemeType.whatsapp
                          ? AppColors.chattingWhite
                          : AppColors.chattingBlack,
                    ),
                    onPressed: () async {
                      // if (widget.isAddingWhileCreatingBroadcast == true) {
                      //   broadcastDesc.clear();
                      //   broadcastName.clear();
                      //   showModalBottomSheet(
                      //       isScrollControlled: true,
                      //       context: context,
                      //       shape: const RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.vertical(
                      //             top: Radius.circular(25.0)),
                      //       ),
                      //       builder: (BuildContext context) {
                      //         // return your layout
                      //         var w = MediaQuery.of(context).size.width;
                      //         return Padding(
                      //           padding: EdgeInsets.only(
                      //               bottom:
                      //                   MediaQuery.of(context).viewInsets.bottom),
                      //           child: Container(
                      //               padding: const EdgeInsets.all(16),
                      //               height:
                      //                   MediaQuery.of(context).size.height / 2.2,
                      //               child: Column(
                      //                   mainAxisSize: MainAxisSize.min,
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.stretch,
                      //                   children: [
                      //                     const SizedBox(
                      //                       height: 12,
                      //                     ),
                      //                     const SizedBox(
                      //                       height: 3,
                      //                     ),
                      //                     Padding(
                      //                       padding:
                      //                           const EdgeInsets.only(left: 7),
                      //                       child: Text(
                      //                         getTranslated(this.context,
                      //                             'setbroadcastdetails'),
                      //                         textAlign: TextAlign.left,
                      //                         style: const TextStyle(
                      //                             fontWeight: FontWeight.bold,
                      //                             fontSize: 16.5),
                      //                       ),
                      //                     ),
                      //                     const SizedBox(
                      //                       height: 10,
                      //                     ),
                      //                     Container(
                      //                       margin:
                      //                           const EdgeInsets.only(top: 10),
                      //                       padding: const EdgeInsets.fromLTRB(
                      //                           0, 0, 0, 0),
                      //                       // height: 63,
                      //                       height: 83,
                      //                       width: w / 1.24,
                      //                       child: CommonTextFormField(
                      //                         controller: broadcastName,
                      //                         leftRightMargin: 0,
                      //                         showIconBoundary: false,
                      //                         boxCornerRadius: 5.5,
                      //                         boxHeight: 50,
                      //                         hintText: getTranslated(
                      //                             this.context, 'broadcastName'),
                      //                         prefixIconButton: Icon(
                      //                           Icons.edit,
                      //                           color:
                      //                               Colors.grey.withOpacity(0.5),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     Container(
                      //                       margin:
                      //                           const EdgeInsets.only(top: 10),
                      //                       padding: const EdgeInsets.fromLTRB(
                      //                           0, 0, 0, 0),
                      //                       // height: 63,
                      //                       height: 83,
                      //                       width: w / 1.24,
                      //                       child: CommonTextFormField(
                      //                         maxLines: 1,
                      //                         controller: broadcastDesc,
                      //                         leftRightMargin: 0,
                      //                         showIconBoundary: false,
                      //                         boxCornerRadius: 5.5,
                      //                         boxHeight: 50,
                      //                         hintText: getTranslated(
                      //                             this.context, 'broadcastDesc'),
                      //                         prefixIconButton: Icon(
                      //                           Icons.message,
                      //                           color:
                      //                               Colors.grey.withOpacity(0.5),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     const SizedBox(
                      //                       height: 6,
                      //                     ),
                      //                     CommonElevatedButton(
                      //                         color: AppColors.lightGreen,
                      //                         child: Padding(
                      //                           padding:
                      //                               const EdgeInsets.fromLTRB(
                      //                                   10, 15, 10, 15),
                      //                           child: Text(
                      //                             getTranslated(
                      //                                 context, 'createbroadcast'),
                      //                             style: const TextStyle(
                      //                                 color: Colors.white,
                      //                                 fontSize: 18),
                      //                           ),
                      //                         ),
                      //                         onPressed: () async {
                      //                           Navigator.of(
                      //                                   scaffold.currentContext!)
                      //                               .pop();
                      //                           List<String> listUsers = [];
                      //                           List<String> listMembers = [];
                      //                           selectedList.forEach((element) {
                      //                             listUsers.add(element[
                      //                                 DatabaseKeys.phone]);
                      //                             listMembers.add(element[
                      //                                 DatabaseKeys.phone]);
                      //                           });
                      //
                      //                           DateTime time = DateTime.now();
                      //                           DateTime time2 = DateTime.now()
                      //                               .add(const Duration(
                      //                                   seconds: 1));
                      //                           Map<String, dynamic>
                      //                               broadcastData = {
                      //                             DatabaseKeys
                      //                                     .broadcastDescription:
                      //                                 broadcastDesc.text.isEmpty
                      //                                     ? ''
                      //                                     : broadcastDesc.text
                      //                                         .trim(),
                      //                             DatabaseKeys.broadCastCreatedOn:
                      //                                 time,
                      //                             DatabaseKeys.broadCastCreatedBy:
                      //                                 widget.currentUserNo,
                      //                             DatabaseKeys.broadcastName:
                      //                                 broadcastName.text.isEmpty
                      //                                     ? 'Unnamed BroadCast'
                      //                                     : broadcastName.text
                      //                                         .trim(),
                      //                             DatabaseKeys.broadcastAdminList:
                      //                                 [widget.currentUserNo],
                      //                             DatabaseKeys.broadCastId:
                      //                                 '${widget.currentUserNo!}--${time.millisecondsSinceEpoch}',
                      //                             DatabaseKeys
                      //                                     .broadcastMembersList:
                      //                                 listMembers,
                      //                             DatabaseKeys
                      //                                     .broadCastLatestMessageTime:
                      //                                 time.millisecondsSinceEpoch,
                      //                             DatabaseKeys.broadcastBlackList:
                      //                                 [],
                      //                           };
                      //
                      //                           listMembers.forEach((element) {
                      //                             broadcastData.putIfAbsent(
                      //                                 element.toString(),
                      //                                 () => time
                      //                                     .millisecondsSinceEpoch);
                      //
                      //                             broadcastData.putIfAbsent(
                      //                                 '$element-joinedOn',
                      //                                 () => time
                      //                                     .millisecondsSinceEpoch);
                      //                           });
                      //                           setStateIfMounted(() {
                      //                             isCreatingBroadcast = true;
                      //                           });
                      //                           await FirebaseFirestore.instance
                      //                               .collection(DatabasePath
                      //                                   .fireStoreCollectionBroadCast)
                      //                               .doc(
                      //                                   '${widget.currentUserNo!}--${time.millisecondsSinceEpoch}')
                      //                               .set(broadcastData)
                      //                               .then((value) async {
                      //                             await FirebaseFirestore.instance
                      //                                 .collection(DatabasePath
                      //                                     .fireStoreCollectionBroadCast)
                      //                                 .doc(
                      //                                     '${widget.currentUserNo!}--${time.millisecondsSinceEpoch}')
                      //                                 .collection(DatabasePath
                      //                                     .fireStoreCollectionBroadCastChat)
                      //                                 .doc(
                      //                                     '${time2.millisecondsSinceEpoch}--${widget.currentUserNo!}')
                      //                                 .set({
                      //                               DatabaseKeys
                      //                                   .broadCastMessageContent: '',
                      //                               DatabaseKeys
                      //                                       .broadCastMessageListOptional:
                      //                                   listMembers,
                      //                               DatabaseKeys
                      //                                       .broadCastMessageTime:
                      //                                   time2
                      //                                       .millisecondsSinceEpoch,
                      //                               DatabaseKeys
                      //                                       .broadCastMessageSendBy:
                      //                                   widget.currentUserNo,
                      //                               DatabaseKeys
                      //                                       .broadCastMessageIsDeleted:
                      //                                   false,
                      //                               DatabaseKeys
                      //                                       .broadCastMessageType:
                      //                                   DatabaseKeys
                      //                                       .broadcastMessageTypeNotificationAddedUser,
                      //                             }).then((value) async {
                      //                               Navigator.of(scaffold
                      //                                       .currentContext!)
                      //                                   .pop();
                      //                             }).catchError((err) {
                      //                               setStateIfMounted(() {
                      //                                 isCreatingBroadcast = false;
                      //                               });
                      //
                      //                               FiberChatSettings.toast(
                      //                                   'Error Creating Broadcast. $err');
                      //                               debugPrint(
                      //                                   'Error Creating Broadcast. $err');
                      //                             });
                      //                           });
                      //                         }),
                      //                   ])),
                      //         );
                      //       });
                      // }
                      // else {
                      //   // List<String> listUsers = [];
                      //   List<String> listMembers = [];
                      //   selectedList.forEach((element) {
                      //     // listUsers.add(element[DatabaseKeys.phone]);
                      //     listMembers.add(element[DatabaseKeys.phone]);
                      //     // listMembers
                      //     //     .add(widget.currentUserNo!);
                      //   });
                      //   DateTime time = DateTime.now();
                      //
                      //   setStateIfMounted(() {
                      //     isCreatingBroadcast = true;
                      //   });
                      //
                      //   Map<String, dynamic> docMap = {
                      //     DatabaseKeys.broadcastMembersList:
                      //         FieldValue.arrayUnion(listMembers)
                      //   };
                      //
                      //   selectedList.forEach((element) async {
                      //     docMap.putIfAbsent(
                      //         '${element[DatabaseKeys.phone]}-joinedOn',
                      //         () => time.millisecondsSinceEpoch);
                      //   });
                      //   setStateIfMounted(() {});
                      //   await FirebaseFirestore.instance
                      //       .collection(DatabasePath.fireStoreCollectionBroadCast)
                      //       .doc(widget.broadcastId)
                      //       .update(docMap)
                      //       .then((value) async {
                      //     await FirebaseFirestore.instance
                      //         .collection(
                      //             DatabasePath.fireStoreCollectionBroadCast)
                      //         .doc(
                      //             '${widget.currentUserNo!}--${time.millisecondsSinceEpoch}')
                      //         .collection(
                      //             DatabasePath.fireStoreCollectionBroadCastChat)
                      //         .doc(
                      //             '${time.millisecondsSinceEpoch}--${widget.currentUserNo!}')
                      //         .set({
                      //       DatabaseKeys.broadCastMessageContent: '',
                      //       DatabaseKeys.broadCastMessageListOptional:
                      //           listMembers,
                      //       DatabaseKeys.broadCastMessageTime:
                      //           time.millisecondsSinceEpoch,
                      //       DatabaseKeys.broadCastMessageSendBy:
                      //           widget.currentUserNo,
                      //       DatabaseKeys.broadCastMessageIsDeleted: false,
                      //       DatabaseKeys.broadCastMessageType: DatabaseKeys
                      //           .broadcastMessageTypeNotificationAddedUser,
                      //     }).then((value) async {
                      //       Navigator.of(context).pop();
                      //     }).catchError((err) {
                      //       setStateIfMounted(() {
                      //         isCreatingBroadcast = false;
                      //       });
                      //
                      //       FiberChatSettings.toast(
                      //         getTranslated(context, 'erroraddingbroadcast'),
                      //       );
                      //     });
                      //   });
                      // }
                    })
          ],
        ),
        bottomSheet: selectList == true
            ? const SizedBox(
                height: 0,
                width: 0,
              )
            : Container(
                padding: const EdgeInsets.only(top: 6),
                width: MediaQuery.of(context).size.width,
                height: 97,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // itemCount: _selectedList.reversed
                    //     .toList()
                    //     .length,
                    itemCount: 10,
                    itemBuilder: (context, int index) {
                      return Stack(
                        children: [
                          Container(
                            width: 80,
                            padding: const EdgeInsets.fromLTRB(11, 10, 12, 10),
                            child: Column(
                              children: const [
                                CustomCircleAvatar(
                                    url: "",
                                    // url: selectedList.reversed
                                    //     .toList()[i]
                                    // [DatabaseKeys.photoUrl],
                                    radius: 20),
                                SizedBox(
                                  height: 7,
                                ),
                                CommonText(
                                  // selectedList.reversed.toList()[i]
                                  // [DatabaseKeys.nickName],
                                  text: "Nick Name",
                                  maxLines: 1,
                                  overFlow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            right: 17,
                            top: 5,
                            child: InkWell(
                              onTap: () {
                                // setStateIfMounted(() {
                                //   selectedList.remove(selectedList
                                //       .reversed
                                //       .toList()[i]);
                                // });
                              },
                              child: Container(
                                width: 20.0,
                                height: 20.0,
                                padding: const EdgeInsets.all(2.0),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ), //............
                            ),
                          )
                        ],
                      );
                    }),
              ),
        body: RefreshIndicator(
            onRefresh: () {
              // return contactsProvider.fetchContacts(context,
              //     model, widget.currentUserNo!, widget.prefs);
              return Future(() => Container());
            },
            child: searchContact == true || createBroadcast == true
                ? loading()
                : length == true
                    ? ListView(shrinkWrap: true, children: [
                        Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 2.5),
                            child: const Center(
                              child: CommonText(
                                  text: "No Result",
                                  // getTranslated(context,
                                  //     'nosearchresult'),
                                  textAlign: TextAlign.center,
                                  fontSize: 18,
                                  fontColor: AppColors.grey),
                            ))
                      ])
                    : Padding(
                        padding: EdgeInsets.only(
                            // bottom: _selectedList.length == 0
                            bottom: selectList == false ? 0 : 80),
                        child: Stack(
                          children: [
                            FutureBuilder(
                                future: Future.delayed(const Duration(seconds: 2)),
                                builder: (c, s) => s.connectionState ==
                                        ConnectionState.done
                                    ? Container(
                                        alignment: Alignment.topCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.all(30),
                                          child: Card(
                                            elevation: 0.5,
                                            color: Colors.grey[100],
                                            child: Container(
                                                padding: const EdgeInsets.fromLTRB(
                                                    8, 10, 8, 10),
                                                child: RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(
                                                    children: [
                                                      WidgetSpan(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 2.5,
                                                                  right: 4),
                                                          child: Icon(
                                                            Icons.contact_page,
                                                            color: AppColors
                                                                .lightGreen
                                                                .withOpacity(
                                                                    0.7),
                                                            size: 14,
                                                          ),
                                                        ),
                                                      ),
                                                      TextSpan(
                                                          // text: getTranslated(this.context, 'nosavedcontacts'),
                                                          text:
                                                              "No Saved Contact",
                                                          // text:
                                                          //     'No Saved Contacts available for this task',
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .lightGreen
                                                                  .withOpacity(
                                                                      0.7),
                                                              height: 1.3,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                    ],
                                                  ),
                                                )),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.topCenter,
                                        child: const Padding(
                                            padding: EdgeInsets.all(30),
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      AppColors.blue),
                                            )),
                                      )),
                            // ListView.builder(
                            //   physics:
                            //   AlwaysScrollableScrollPhysics(),
                            //   padding: EdgeInsets.all(10),
                            //   itemCount: contactsProvider
                            //       .joinedUserPhoneStringAsInServer
                            //       .length,
                            //   itemBuilder: (context, idx) {
                            //     String phone = contactsProvider
                            //         .joinedUserPhoneStringAsInServer[
                            //     idx]
                            //         .phone;
                            //     Widget? alreadyAddedUser = widget
                            //         .isAddingWhileCreatingBroadcast ==
                            //         true
                            //         ? null
                            //         : broadcastList
                            //         .lastWhere((element) =>
                            //     element.docmap[
                            //     Dbkeys
                            //         .broadcastID] ==
                            //         widget
                            //             .broadcastID)
                            //         .docmap[Dbkeys
                            //         .broadcastMEMBERSLIST]
                            //         .contains(phone)
                            //         ? SizedBox()
                            //         : null;
                            //     return alreadyAddedUser ??
                            //         FutureBuilder(
                            //             future:
                            //             contactsProvider
                            //                 .getUserDoc(
                            //                 phone),
                            //             builder: (BuildContext
                            //             context,
                            //                 AsyncSnapshot<
                            //                     DocumentSnapshot>
                            //                 snapshot) {
                            //               if (snapshot
                            //                   .hasData &&
                            //                   snapshot.data!
                            //                       .exists) {
                            //                 DocumentSnapshot
                            //                 user =
                            //                 snapshot
                            //                     .data!;
                            //                 return Container(
                            //                   color: Colors
                            //                       .white,
                            //                   child: Column(
                            //                     children: [
                            //                       ListTile(
                            //                         leading:
                            //                         customCircleAvatar(
                            //                           url: user[
                            //                           Dbkeys.photoUrl],
                            //                           radius:
                            //                           22.5,
                            //                         ),
                            //                         trailing:
                            //                         Container(
                            //                           decoration:
                            //                           BoxDecoration(
                            //                             border: Border.all(
                            //                                 color: fiberchatGrey,
                            //                                 width: 1),
                            //                             borderRadius:
                            //                             BorderRadius.circular(5),
                            //                           ),
                            //                           child: _selectedList.lastIndexWhere((element) => element[Dbkeys.phone] == phone) >=
                            //                               0
                            //                               ? Icon(
                            //                             Icons.check,
                            //                             size: 19.0,
                            //                             color: fiberchatLightGreen,
                            //                           )
                            //                               : Icon(
                            //                             null,
                            //                             size: 19.0,
                            //                           ),
                            //                         ),
                            //                         title: Text(
                            //                             user[Dbkeys.nickname] ??
                            //                                 '',
                            //                             style:
                            //                             TextStyle(color: fiberchatBlack)),
                            //                         subtitle: Text(
                            //                             phone,
                            //                             style:
                            //                             TextStyle(color: fiberchatGrey)),
                            //                         contentPadding: EdgeInsets.symmetric(
                            //                             horizontal:
                            //                             10.0,
                            //                             vertical:
                            //                             0.0),
                            //                         onTap:
                            //                             () {
                            //                           // setStateIfMounted(
                            //                           //         () {
                            //                           //       if (_selectedList.lastIndexWhere((element) => element[Dbkeys.phone] == phone) >=
                            //                           //           0) {
                            //                           //         _selectedList.remove(snapshot.data!);
                            //                           //         setStateIfMounted(() {});
                            //                           //       } else {
                            //                           //         _selectedList.add(snapshot.data!);
                            //                           //         setStateIfMounted(() {});
                            //                           //       }
                            //                           //     });
                            //                         },
                            //                       ),
                            //                       Divider()
                            //                     ],
                            //                   ),
                            //                 );
                            //               }
                            //               return SizedBox();
                            //             });
                            //   },
                            // ),
                          ],
                        ),
                      )),
      ),
    );
  }

  Stack loading() {
    return Stack(children: const [
      Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.blue),
      ))
    ]);
  }
}
