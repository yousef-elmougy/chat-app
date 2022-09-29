import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../data_sources/auth_remote_data_source.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserCredential>> register({String? password, email});

  Future<Either<Failure, UserCredential>> login({String? password, email});

  Future<Either<Failure, void>> createUser({String? name, phone, email, uId});

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers();
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.authRemoteDataSource});

  final AuthRemoteDataSource authRemoteDataSource;

  /// REGISTER

  @override
  Future<Either<Failure, UserCredential>> register(
      {String? password, email}) async {
    try {
      UserCredential registerCredential =
          await authRemoteDataSource.register(email: email, password: password);
      return Right(registerCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Left(FirebaseFailure('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        return Left(
            FirebaseFailure('The account already exists for that email.'));
      } else {
        return Left(FirebaseFailure(e.toString()));
      }
    }
  }

  /// LOGIN

  @override
  Future<Either<Failure, UserCredential>> login(
      {String? password, email}) async {
    try {
      UserCredential loginCredential =
          await authRemoteDataSource.login(password: password, email: email);
      return Right(loginCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Left(FirebaseFailure('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        return Left(FirebaseFailure('Wrong password provided for that user.'));
      } else {
        return Left(FirebaseFailure(e.toString()));
      }
    }
  }

  /// CREATE USER

  @override
  Future<Either<Failure, void>> createUser(
      {String? name, phone, email, uId}) async {
    try {
      return Right(
        await authRemoteDataSource.createUser(
            uId: uId, phone: phone, email: email, name: name),
      );
    } on ServerException {
      return Left(ServerFailure());
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  /// GET ALL USER

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() =>
      authRemoteDataSource.getAllUsers();
}
