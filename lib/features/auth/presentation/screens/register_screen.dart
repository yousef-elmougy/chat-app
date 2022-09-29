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

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: authCubit.registerForm,
          child: SingleChildScrollView(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is RegisterError) {
                  return showToast(
                      msg: state.error, color: Colors.red);
                }

              },
              builder: (context, state) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpace(10),
                  const Text('REGISTER',
                      style: TextStyle(fontSize: 40)),
                  const VerticalSpace(5),
                  CustomTextFormField(
                    prefixIcon: Icons.person,
                    controller: authCubit.registerNameController,
                    validator: (String? value) =>
                        validInput(context, value!, 3, 20, 'username'),
                    labelText: 'name',
                    hintText: 'name',
                  ),
                  const VerticalSpace(3),
                  CustomTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email,
                    controller: authCubit.registerEmailController,
                    validator: (String? value) =>
                        validInput(context, value!, 10, 30, 'email'),
                    labelText: 'email',
                    hintText: 'email',
                  ),
                  const VerticalSpace(3),
                  CustomTextFormField(
                    keyboardType: TextInputType.number,
                    prefixIcon: Icons.phone,
                    controller: authCubit.registerPhoneController,
                    validator: (String? value) =>
                        validInput(context, value!, 7, 11, 'phone'),
                    labelText: 'phone',
                    hintText: 'phone',
                  ),
                  const VerticalSpace(3),
                  CustomTextFormField(
                    controller:
                        authCubit.registerPasswordController,
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
                  state is RegisterLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          title: 'REGISTER',
                          onTap: ()  => authCubit.register(context),
                        ),
                  const VerticalSpace(1),
                  const CustomTextBottom(
                      text: 'do you have an account  ',
                      textBottom: 'LOGIN',
                      routeName: Routes.loginScreen),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
