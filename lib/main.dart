import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/routes/app_router.dart';
import 'features/auth/data/data_sources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/chat/data/data_sources/chat_remote_data_source.dart';
import 'features/chat/data/repositories/chat_repository.dart';
import 'features/chat/presentation/cubit/chat_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(
              authRepository: AuthRepositoryImpl(
                  authRemoteDataSource: AuthRemoteDataSourceImpl()))..getAllUsers(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(
              chatRepository: ChatRepositoryImpl(
                  chatRemoteDataSource: ChatRemoteDataSourceImpl()))..getMessage(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
