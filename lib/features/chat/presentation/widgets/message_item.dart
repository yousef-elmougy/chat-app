
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {

  final String text;
  final bool isMe;

  const MessageItem({Key? key, required this.text, required this.isMe}) : super(key: key);

  @override
  Widget build(BuildContext context) => Align(
        alignment: isMe ? Alignment.topLeft : Alignment.topRight,
        child: Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.blue[200] : Colors.orange[200],
            borderRadius: isMe
                ? const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
          ),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: Text(text),
        ),
      );
}
