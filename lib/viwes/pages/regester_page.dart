import 'package:ecommerce_app/utils/app_colores.dart';
import 'package:ecommerce_app/utils/app_routes.dart';
import 'package:ecommerce_app/view_model/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/viwes/widgets/label_with_textfield_new_card.dart';
import 'package:ecommerce_app/viwes/widgets/main_button.dart';
import 'package:ecommerce_app/viwes/widgets/socail_media_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start shopping with create your account!',
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge!.copyWith(color: AppColors.grey),
                  ),
                  const SizedBox(height: 24),
                  LabelWithTextField(
                    label: 'Username',
                    controller: usernameController,
                    prefixIcon: Icons.person,
                    hintText: 'Enter you username',
                  ),
                  const SizedBox(height: 24),
                  LabelWithTextField(
                    label: 'Email',
                    controller: emailController,
                    prefixIcon: Icons.email,
                    hintText: 'Enter you email',
                  ),
                  const SizedBox(height: 24),
                  LabelWithTextField(
                    label: 'Password',
                    controller: passwordController,
                    prefixIcon: Icons.password,
                    hintText: 'Enter you password',
                    // TODO: Make this visibility works well
                    obsecureText: true,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () {},
                    ),
                  ),
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
                    buildWhen:
                        (previous, current) =>
                            current is AuthFailure || current is AuthFailure,
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return MainButton(isLoading: true);
                      }
                      return MainButton(
                        text: 'Create Account',
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await cubit.registerWithEmailandPassword(
                              emailController.text,
                              passwordController.text,
                              usernameController.text,
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
                            Navigator.of(context).pop();
                          },
                          child: const Text('You have an account? Login'),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Or using other method',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(color: AppColors.grey),
                        ),
                        const SizedBox(height: 16),
                        SocialMediaButton(
                          text: 'Signup with Google',
                          imgUrl:
                              'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
                          onTap: () {},
                        ),
                        const SizedBox(height: 16),
                        SocialMediaButton(
                          text: 'Signup with Facebook',
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
