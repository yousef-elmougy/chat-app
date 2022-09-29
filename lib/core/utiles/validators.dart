
import 'package:chat_app/core/extentions/validation_extension.dart';
import 'package:flutter/material.dart';

validInput(BuildContext context,String val, int min, int max, String type) {

  if (val.isNotNull) {

    // not valid username
    if (type == "username" && val.isValidName) return "not valid username";

    // not valid email
    if (type == "email" && val.isValidEmail) return "not valid email";

    // not valid phone
    if (type == "phone" && val.isValidPhone) return "not valid phone";

    // not valid password
    if (type == "password" && val.isValidPassword) return "not valid password";

    // can't be Empty
    if (val.isEmpty) return "can't be Empty";

    // can't be less than $min
    if (val.length < min) return "can't be less than $min";

    // can't be larger than $max
    if (val.length > max) return "can't be larger than $max";
  }
}
