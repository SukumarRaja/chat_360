import 'package:chat_360/ui/themes/app_colors.dart';
import 'package:flutter/material.dart';

import '../../widgets/common_text.dart';

class InfiniteListView extends StatefulWidget {
  const InfiniteListView(
      {Key? key,
      this.datatype,
      this.list,
      this.isReverse,
      this.padding,
      this.parentId})
      : super(key: key);

  // final CallHistoryProvider? callHistory;
  final String? datatype;
  final Widget? list;

  // final Query? refData;
  final bool? isReverse;
  final EdgeInsets? padding;
  final String? parentId;

  @override
  State<InfiniteListView> createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController.offset >=
            scrollController.position.maxScrollExtent / 2 &&
        !scrollController.position.outOfRange) {
      if (widget.datatype == 'CALLHISTORY') {
        // if (widget.callHistory!.hasNext) {
        //   widget.callHistory!
        //       .fetchNextData(widget.datatype, widget.refData, false);
        // }
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    bool callHistory = false;
    return ListView(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      controller: scrollController,
      padding: widget.padding ?? const EdgeInsets.all(0),
      children: widget.datatype == "Call History"
          ? [
              Container(child: widget.list),
              callHistory == true
                  ? Center(
                      child: GestureDetector(
                        // child: SizedBox(
                        //   height: widget.callHistory!.receivedDocs.isEmpty
                        //       ? 205
                        //       : 100,
                        //   width: widget.callHistory!.receivedDocs.isEmpty
                        //       ? 205
                        //       : 100,
                        //   child: const Center(
                        //     child: CircularProgressIndicator(
                        //         valueColor: AlwaysStoppedAnimation<Color>(
                        //             AppColors.lightGreen)),
                        //   ),
                        // ),
                        onTap: () {
                          // widget.callHistory!.fetchNextData(
                          //     widget.datatype, widget.refData, false);
                        },
                      ),
                    )
                  : callHistory == false
                      ? Align(
                          alignment: Alignment.center,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  28,
                                  MediaQuery.of(context).size.height / 8.7,
                                  28,
                                  10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      padding: const EdgeInsets.all(22),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        // borderRadius: BorderRadius.all(
                                        //   Radius.circular(20),
                                        // ),
                                      ),
                                      height: 100,
                                      width: 100,
                                      child: const Icon(Icons.call,
                                          size: 60, color: Colors.grey)),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  CommonText(
                                    text:"No Calls",
                                    // getTranslated(context, 'nocalls'),
                                    textAlign: TextAlign.center,
                                        fontColor: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CommonText(
                                    text:"All",
                                    // getTranslated(context, 'allav'),
                                    textAlign: TextAlign.center,
                                        fontColor: Colors.grey,
                                        fontSize: 13.9,
                                        fontWeight: FontWeight.w400,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : SizedBox()
            ]
          : [],
    );
  }
}
