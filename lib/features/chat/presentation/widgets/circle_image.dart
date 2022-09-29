import 'package:chat_app/core/extentions/media_query_extension.dart';
import 'package:flutter/material.dart';

import 'cache_image.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({Key? key,  this.radius, this.text}) : super(key: key);
  final String? text;
  final double? radius;

  @override
  Widget build(BuildContext context) =>ClipOval(
    child: CacheImage(
      image:text,
      height:context.heightInPercent(radius ?? 6) ,
      width: context.heightInPercent(radius ?? 6),
      boxFit:BoxFit.cover ,
    ),
  );
}
