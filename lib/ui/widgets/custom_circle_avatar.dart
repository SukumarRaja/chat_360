import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({Key? key, this.url, this.radius}) : super(key: key);
  final String? url;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    if (url == null || url == '') {
      return CircleAvatar(
        backgroundColor: const Color(0xffE6E6E6),
        radius: radius ?? 30,
        child: const Icon(
          Icons.person,
          color: Color(0xffCCCCCC),
        ),
      );
    } else {
      return CachedNetworkImage(
        imageUrl: url!,
        imageBuilder: (context, imageProvider) => CircleAvatar(
          backgroundColor: const Color(0xffE6E6E6),
          radius: radius ?? 30,
          backgroundImage: NetworkImage('$url'),
        ),
        placeholder: (context, url) => CircleAvatar(
          backgroundColor: const Color(0xffE6E6E6),
          radius: radius ?? 30,
          child: const Icon(
            Icons.person,
            color: Color(0xffCCCCCC),
          ),
        ),
        errorWidget: (context, url, error) => CircleAvatar(
          backgroundColor: const Color(0xffE6E6E6),
          radius: radius ?? 30,
          child: const Icon(
            Icons.person,
            color: Color(0xffCCCCCC),
          ),
        ),
      );
    }
  }
}
