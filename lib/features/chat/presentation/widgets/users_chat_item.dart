
import 'package:chat_app/core/extentions/media_query_extension.dart';
import 'package:chat_app/core/extentions/routes_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/routes/routes.dart';
import '../../../auth/data/model/user_model.dart';

class UsersChatItem extends StatelessWidget {


  const UsersChatItem({Key? key, required this.userModel}) : super(key: key);
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return userModel.uId != FirebaseAuth.instance.currentUser!.uid
        ? InkWell(
            onTap: () => Routes.chatDetailsScreen.goTo(context,args: userModel),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: context.heightInPercent(12),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(userModel.name.toString(),
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios, size: 30),
                  ],
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
