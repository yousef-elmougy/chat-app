import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../data_sources/chat_remote_data_source.dart';

abstract class ChatRepository {
  Future<Either<Failure, void>> sendMessage(
      {String? text, receiverId, senderId, DateTime? dateTime});

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessage(
      {String? receiverId, senderId});
}

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl({required this.chatRemoteDataSource});

  final ChatRemoteDataSource chatRemoteDataSource;

  @override
  Future<Either<Failure, void>> sendMessage(
      {String? text,
      receiverId,
      senderId,
      DateTime? dateTime}) async {
    try {
      return Right(
        await chatRemoteDataSource.sendMessage(
          receiverId: receiverId,
          senderId: senderId,
          dateTime: dateTime,
          text: text,
        ),
      );
    } on ServerException {
      return Left(ServerFailure());
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessage(
          {String? receiverId, senderId}) =>
      chatRemoteDataSource.getMessage(
          receiverId: receiverId, senderId: senderId);
}
