
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config/database_keys.dart';
import '../../provider/seen.dart';
import '../../services/localization/language_constants.dart';
import '../../utility/enum.dart';
import '../themes/app_colors.dart';


class Bubble extends StatelessWidget {
  const Bubble({
    super.key,
    required this.isUrlText,
    required this.child,
    required this.timeStamp,
    required this.delivered,
    required this.isMe,
    required this.isContinuing,
    required this.messageType,
    this.isBroadcastMessage,
    required this.isMessageDeleted,
    required this.is24hrsFormat,
    required this.messageDoc,
  });

  final dynamic isUrlText;
  final dynamic messageType;
  final int? timeStamp;
  final Widget child;
  final dynamic delivered;
  final bool isMe, isContinuing, isMessageDeleted;
  final bool? isBroadcastMessage;
  final bool is24hrsFormat;
  final Map<String, dynamic> messageDoc;

  humanReadableTime() => DateFormat(is24hrsFormat == true ? 'HH:mm' : 'h:mm a')
      .format(DateTime.fromMillisecondsSinceEpoch(timeStamp!));

  getSeenStatus(seen) {
    if (seen is bool) return true;
    if (seen is String) return true;
    return timeStamp! <= seen;
  }

  @override
  Widget build(BuildContext context) {
    final bool seen = getSeenStatus(SeenProvider.of(context).value);
    final bg = isMe ? AppColors.chattingGreen : AppColors.chattingWhite;
    final align = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    dynamic icon = delivered is bool && delivered
        ? (seen ? Icons.done_all : Icons.done)
        : Icons.access_time;
    final color = isMe
        ? AppColors.chattingBlack.withOpacity(0.5)
        : AppColors.chattingBlack.withOpacity(0.5);
    icon = Icon(icon, size: 14.0, color: seen ? Colors.lightBlue : color);
    if (delivered is Future) {
      icon = FutureBuilder(
          future: delivered,
          builder: (context, res) {
            switch (res.connectionState) {
              case ConnectionState.done:
                return Icon((seen ? Icons.done_all : Icons.done),
                    size: 13.0, color: seen ? Colors.lightBlue : color);
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
              default:
                return Icon(Icons.access_time,
                    size: 13.0, color: seen ? Colors.lightBlue : color);
            }
          });
    }
    dynamic radius = isMe
        ? const BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0),
          )
        : const BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          );
    dynamic margin = const EdgeInsets.only(top: 20.0, bottom: 1.5);
    if (isContinuing) {
      radius = const BorderRadius.all(Radius.circular(5.0));
      margin = const EdgeInsets.all(1.9);
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: align,
        children: <Widget>[
          Container(
            margin: margin,
            padding: const EdgeInsets.all(8.0),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.67),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: radius,
            ),
            child: Stack(
              children: <Widget>[
                isMessageDeleted == true
                    ? deletedMessageWidget(
                        isMe, isBroadcastMessage, context, is24hrsFormat)
                    : Padding(
                        padding: messageType == null ||
                                messageType == MessageType.location ||
                                messageType == MessageType.image ||
                                isUrlText == true ||
                                messageType == MessageType.text
                            ? child is Container ||
                                    messageDoc.containsKey(
                                            DatabaseKeys.isReply) ==
                                        true
                                ? messageDoc[DatabaseKeys.isReply] == true ||
                                        child is Container
                                    ? const EdgeInsets.fromLTRB(0, 0, 0, 17)
                                    : EdgeInsets.only(
                                        bottom: isUrlText == true ? 20 : 0,
                                        right: isUrlText == true
                                            ? 0
                                            : messageType ==
                                                    MessageType.location
                                                ? 0
                                                : isMe
                                                    ? isBroadcastMessage ==
                                                                null ||
                                                            isBroadcastMessage ==
                                                                false
                                                        ? is24hrsFormat
                                                            ? 45
                                                            : 65
                                                        : is24hrsFormat
                                                            ? 62
                                                            : 81.0
                                                    : isBroadcastMessage ==
                                                                null ||
                                                            isBroadcastMessage ==
                                                                false
                                                        ? is24hrsFormat
                                                            ? 33
                                                            : 48
                                                        : is24hrsFormat
                                                            ? 48
                                                            : 60.0)
                                : EdgeInsets.only(
                                    right: messageType == MessageType.location
                                        ? 0
                                        : isMe
                                            ? isBroadcastMessage == null ||
                                                    isBroadcastMessage == false
                                                ? is24hrsFormat
                                                    ? 45
                                                    : 65
                                                : is24hrsFormat
                                                    ? 62
                                                    : 81.0
                                            : isBroadcastMessage == null ||
                                                    isBroadcastMessage == false
                                                ? is24hrsFormat
                                                    ? 33
                                                    : 48
                                                : is24hrsFormat
                                                    ? 48
                                                    : 60.0)
                            : child is Container
                                ? const EdgeInsets.all(0.0)
                                : const EdgeInsets.only(right: 5.0, bottom: 20),
                        child: child),
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: Row(
                    children: <Widget>[
                      isBroadcastMessage == null || isBroadcastMessage == false
                          ? const SizedBox(
                              height: 0,
                              width: 0,
                            )
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                              child: Icon(
                                Icons.campaign,
                                size: 14.3,
                                color: color,
                              ),
                            ),
                      Text(humanReadableTime().toString() + (isMe ? ' ' : ''),
                          style: TextStyle(
                            color: color,
                            fontSize: 10.0,
                          )),

                      isMe ? icon : const SizedBox()
                      // ignore: unnecessary_null_comparison
                    ].where((o) => o != null).toList(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget deletedMessageWidget(bool isMe, bool? isBroadcastMessage,
    BuildContext context, bool is24hrsFormat) {
  return Padding(
    padding: EdgeInsets.only(
        right: isMe
            ? isBroadcastMessage == null || isBroadcastMessage == false
                ? is24hrsFormat
                    ? 48
                    : 60
                : is24hrsFormat
                    ? 73
                    : 81
            : isBroadcastMessage == null || isBroadcastMessage == false
                ? is24hrsFormat
                    ? 38
                    : 55
                : is24hrsFormat
                    ? 48
                    : 50),
    child: Text(
      getTranslated(context, 'msgdeleted'),
      textAlign: isMe ? TextAlign.right : TextAlign.left,
      style: const TextStyle(
          fontSize: 15.0, fontStyle: FontStyle.italic, color: Colors.black45),
    ),
  );
}
