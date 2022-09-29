
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/data/model/user_model.dart';
import '../cubit/chat_cubit.dart';
import '../widgets/message_item.dart';

class ChatDetailsScreen extends StatelessWidget {

  final UserModel userModel;

  const ChatDetailsScreen({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    chatCubit.getMessage(receiverId: userModel.uId);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(userModel.name.toString(),
                  style: Theme.of(context).textTheme.titleLarge),
            ),
          ],
        ),
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: chatCubit.messages.length,
                    itemBuilder: (context, index) {
                      return MessageItem(
                          text: chatCubit.messages[index].text.toString(),
                          isMe: userModel.uId != chatCubit.messages[index].senderId);
                    },
                  ),
                ),
                TextField(
                  controller: chatCubit.messageController,
                  onSubmitted: (value) =>
                      chatCubit.sendMessage(receiverId: userModel.uId),
                  decoration: InputDecoration(
                    hintText: 'Add Message...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          chatCubit.sendMessage(receiverId: userModel.uId);
                        }),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
