
import 'package:chat_app/core/extentions/routes_extension.dart';
import 'package:flutter/material.dart';

class CustomTextBottom extends StatelessWidget {
  const CustomTextBottom(
      {Key? key,
      required this.text,
      required this.textBottom,
      required this.routeName})
      : super(key: key);

  final String text;
  final String textBottom;
  final String routeName;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: const TextStyle(fontSize: 15)),
          MaterialButton(
              onPressed: () => routeName.goToReplace(context),
              child: Text(
                textBottom,
                style: const TextStyle(color: Colors.blue),
              )),
        ],
      );
}
