
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utiles/constant.dart';
import '../../../../core/utiles/custom_space.dart';
import '../../../../core/utiles/validators.dart';
import '../cubit/auth_state.dart';
import '../widgets/custom_button.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/register_login_text_bottom.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: authCubit.loginForm,
          child: SingleChildScrollView(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is LoginError) {
                  return showToast(
                      msg: state.error, color: Colors.red);
                }
              },
              builder: (context, state) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpace(20),
                  const Text(
                    'LOGIN}',
                    style: TextStyle(fontSize: 40),
                  ),
                  const VerticalSpace(7),
                  CustomTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email,
                    controller: authCubit.loginEmailController,
                    validator: (String? value) =>
                        validInput(context, value!, 10, 30, 'email'),
                    labelText: 'email',
                    hintText: 'email',
                  ),
                  const VerticalSpace(4),
                  CustomTextFormField(
                    controller: authCubit.loginPasswordController,
                    prefixIcon: Icons.lock,
                    suffixIcon: authCubit.changeIcon,
                    onPressedSuffixIcon: authCubit.changeVisibility,
                    obscureText: authCubit.changeObscure,
                    validator: (String? value) =>
                        validInput(context, value!, 6, 30, 'password'),
                    labelText: 'password',
                    hintText: 'password',
                  ),
                  const VerticalSpace(7),
                  state is LoginLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          title: 'LOGIN',
                          onTap: () => authCubit.login(context),

                        ),
                  const VerticalSpace(2),
                   const CustomTextBottom(
                      text: 'don\'t have an account ?  ',
                      textBottom: 'REGISTER',
                      routeName: Routes.registerScreen),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
