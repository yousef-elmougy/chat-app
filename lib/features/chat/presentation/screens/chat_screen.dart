import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/cubit/auth_state.dart';
import '../../../auth/presentation/widgets/custom_button.dart';
import '../widgets/users_chat_item.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => authCubit.users[index].uId !=
                          FirebaseAuth.instance.currentUser!.uid
                      ? const Divider()
                      : const SizedBox(),
                  itemCount: authCubit.users.length,
                  itemBuilder: (context, index) =>
                      UsersChatItem(userModel: authCubit.users[index]),
                ),
              ),
              CustomButton(
                title: 'SIGN OUT',
                onTap: () {
                  authCubit.signOut(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
