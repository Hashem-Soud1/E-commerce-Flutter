import 'package:ecommerce_app/utils/app_colores.dart';
import 'package:ecommerce_app/utils/app_routes.dart';
import 'package:ecommerce_app/view_model/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/viwes/widgets/label_with_textfield_new_card.dart';
import 'package:ecommerce_app/viwes/widgets/main_button.dart';
import 'package:ecommerce_app/viwes/widgets/socail_media_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Login Account',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please, login with registered account!',
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge!.copyWith(color: AppColors.grey),
                  ),
                  const SizedBox(height: 25),
                  LabelWithTextField(
                    label: 'Email',
                    controller: emailController,
                    prefixIcon: Icons.email,
                    hintText: 'Enter you email',
                  ),
                  const SizedBox(height: 20),
                  LabelWithTextField(
                    label: 'Password',
                    controller: passwordController,
                    prefixIcon: Icons.password,
                    hintText: 'Enter you password',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () {},
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.REGISTER);
                      },
                      child: const Text('Forgot Password'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  BlocConsumer<AuthCubit, AuthState>(
                    bloc: cubit,
                    listenWhen:
                        (previous, current) =>
                            current is AuthSuccess || current is AuthFailure,
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        Navigator.of(context).pushNamed(AppRoutes.HOME);
                      } else if (state is AuthFailure) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                    },
                    buildWhen: (previous, current) => current is AuthLoading,
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return MainButton(isLoading: true);
                      }
                      return MainButton(
                        text: 'Login',
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await cubit.loginWithEmailandPassword(
                              emailController.text,
                              passwordController.text,
                            );
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(AppRoutes.REGISTER);
                          },
                          child: const Text('Don\'t have an account? Register'),
                        ),
                        Text(
                          'Or using other method',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(color: AppColors.grey),
                        ),
                        const SizedBox(height: 14),
                        BlocConsumer<AuthCubit, AuthState>(
                          bloc: cubit,
                          listenWhen:
                              (previous, current) =>
                                  current is AuthGoogleSignInSuccess ||
                                  current is AuthGoogleSignInFailure,
                          listener: (context, state) {
                            if (state is AuthGoogleSignInSuccess) {
                              Navigator.of(context).pushNamed(AppRoutes.HOME);
                            } else if (state is AuthGoogleSignInFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message)),
                              );
                            }
                          },
                          buildWhen:
                              (previous, current) =>
                                  current is AuthGoogleSignInLoading,
                          builder: (context, state) {
                            if (state is AuthGoogleSignInLoading) {
                              return MainButton(isLoading: true);
                            }
                            return SocialMediaButton(
                              text: 'Login with Google',
                              imgUrl:
                                  'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
                              onTap: () {
                                cubit.signInWithGoogle();
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        SocialMediaButton(
                          text: 'Login with Facebook',
                          imgUrl:
                              'https://www.freepnglogos.com/uploads/facebook-logo-icon/facebook-logo-icon-facebook-logo-png-transparent-svg-vector-bie-supply-15.png',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
