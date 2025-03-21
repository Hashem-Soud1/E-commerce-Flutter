import 'package:ecommerce_app/utils/app_routes.dart';
import 'package:ecommerce_app/view_model/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/viwes/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: BlocConsumer<AuthCubit, AuthState>(
          bloc: cubit,
          listenWhen:
              (previous, current) =>
                  current is AuthSignedOut || current is AuthSignOutFailure,

          listener: (context, state) {
            if (state is AuthSignedOut) {
              Navigator.of(
                context,
                rootNavigator: true,
              ).pushNamedAndRemoveUntil(AppRoutes.LOGIN, (route) => false);
            } else if (state is AuthSignOutFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          buildWhen: (previous, current) => current is AuthSignigOut,
          builder: (context, state) {
            if (state is AuthSignigOut) {
              return MainButton(isLoading: true);
            }
            return MainButton(
              onTap: () async => await cubit.signOut(),
              text: 'SignOut',
            );
          },
        ),
      ),
    );
  }
}
