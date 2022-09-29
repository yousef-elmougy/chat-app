import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utiles/constant.dart';
import '../../data/models/chat_model.dart';
import '../../data/repositories/chat_repository.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required this.chatRepository}) : super(ChatInitial());

  final ChatRepository chatRepository;

  final TextEditingController messageController = TextEditingController();

  Future<void> sendMessage({String? receiverId}) async {
    emit(SendMessageLoading());
    await chatRepository
        .sendMessage(
            senderId: FirebaseAuth.instance.currentUser!.uid,
            receiverId: receiverId,
            dateTime: DateTime.now(),
            text: messageController.text)
        .then((value) => value.fold(
            (failure) =>
                emit(SendMessageError(mapFailureToMsg(failure))),
            (value) {
              messageController.clear();
              emit(SendMessageLoaded());
            }));
  }

  /// GET MESSAGE
  List<ChatModel> messages = [];

  Future<void> getMessage({String? receiverId}) async {
    emit(GetMessageLoading());
    chatRepository
        .getMessage(senderId:FirebaseAuth.instance.currentUser!.uid, receiverId: receiverId)
        .listen((event) {
          messages =
            event.docs.map((e) => ChatModel.fromJson(e.data())).toList();
          emit(GetMessageLoaded());
        });
  }


}
