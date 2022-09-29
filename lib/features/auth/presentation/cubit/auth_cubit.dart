
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utiles/constant.dart';
import '../../data/model/user_model.dart';
import '../../data/repositories/auth_repository.dart';
import 'auth_state.dart';


class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepository}) : super(AuthInitial());
  final AuthRepository authRepository;

  /// REGISTER

  final registerForm = GlobalKey<FormState>();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerNameController = TextEditingController();
  final TextEditingController registerPhoneController = TextEditingController();
  final TextEditingController registerPasswordController =
      TextEditingController();

  Future<void> register(context) async {
    if (registerForm.currentState!.validate()) {
      emit(RegisterLoading());
      await authRepository
          .register(
              email: registerEmailController.text.trim(),
              password: registerPasswordController.text.trim())
          .then((value) => value.fold(
                  (failure) =>
                      emit(RegisterError(mapFailureToMsg(failure))),
                  (value) {
                createUser(
                    name: registerNameController.text.trim(),
                    email: value.user?.email,
                    phone: registerPhoneController.text.trim(),
                    uId: value.user?.uid);
                emit(RegisterLoaded());
              }));
    }
  }

  /// LOGIN

  final loginForm = GlobalKey<FormState>();
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  Future<void> login(context) async {
    if (loginForm.currentState!.validate()) {
      emit(LoginLoading());
      await authRepository
          .login(
              email: loginEmailController.text.trim(),
              password: loginPasswordController.text.trim())
          .then((value) => value.fold(
              (failure) => emit(LoginError(mapFailureToMsg(failure))),
              (value) => emit(LoginLoaded())));
    }
  }

  /// SIGN OUT

  Future<void> signOut(context) async {
    emit(SignOutLoading());
    await FirebaseAuth.instance
        .signOut()
        .then((value) => emit(SignOutLoaded()))
        .catchError((error) => emit(SignOutError(error)));
  }

  /// PASSWORD VISIBILITY
  bool isVisible = false;

  void changeVisibility() => emit(ChangeVisibility(isVisible = !isVisible));

  IconData get changeIcon =>
      isVisible ? Icons.visibility : Icons.visibility_off;

  bool get changeObscure => isVisible ? false : true;



  /// CREATE USER

  Future<void> createUser({String? name, phone, email, uId}) async {
    emit(CreateUserLoading());
    await authRepository
        .createUser(uId: uId, phone: phone, email: email, name: name)
        .then((value) => value.fold(
            (failure) =>
            emit(CreateUserError(mapFailureToMsg(failure))),
            (value) => emit(CreateUserLoaded())));
  }

  /// GET ALL USERS

  List<UserModel> users = [];

  void getAllUsers() {
    emit(GetAllUsersLoading());
    authRepository.getAllUsers().listen((event) {
      users = event.docs.map((e) => UserModel.fromJson(e.data())).toList();
      emit(GetAllUsersLoaded());
    });
  }


}
