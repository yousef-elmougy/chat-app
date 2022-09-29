
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../error/failures.dart';
import 'app_strings.dart';

String mapFailureToMsg(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return AppStrings.serverFailure;
    case CacheFailure:
      return AppStrings.cacheFailure;
    case FirebaseFailure:
      final FirebaseFailure firebaseFailure = failure as FirebaseFailure;
      return firebaseFailure.toString();

    default:
      return AppStrings.unExpectedError;
  }
}

void showToast({required String msg, Color? color, ToastGravity? gravity}) =>
    Fluttertoast.showToast(
      toastLength: Toast.LENGTH_LONG,
      msg: msg,
      backgroundColor: color ?? Colors.green,
      gravity: gravity ?? ToastGravity.BOTTOM,
    );