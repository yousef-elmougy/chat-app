
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';

abstract class AuthRemoteDataSource {

  Future<UserCredential> register({String? password, String? email});

  Future<UserCredential> login({String? password, String? email});

  Future<void> createUser({String? name, phone, email, uId});

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers();
}


class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  @override
  Future<UserCredential> register({String? password, String? email}) async =>
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);

  @override
  Future<UserCredential> login({String? password, String? email}) async =>
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);


  @override
  Future<void> createUser({String? name, phone, email, uId}) async {
    UserModel userModel = UserModel(
      uId: uId,
      phone: phone,
      email: email,
      name: name,
    );

    void firebaseFirestore = await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toJson());
    return firebaseFirestore;
  }


  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() =>
      FirebaseFirestore.instance
          .collection('users')
          .snapshots(includeMetadataChanges: true);

}
