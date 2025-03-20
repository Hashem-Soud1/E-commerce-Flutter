import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/utils/app_router.dart';
import 'package:ecommerce_app/utils/app_routes.dart';
import 'package:ecommerce_app/view_model/auth_cubit/auth_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AuthCubit()..checkAuth();
      },
      child: Builder(
        builder: (context) {
          final cubit = BlocProvider.of<AuthCubit>(context);

          return BlocBuilder<AuthCubit, AuthState>(
            bloc: cubit,
            buildWhen: (previous, current) => current is AuthSuccess,
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,

                title: 'E-commerc FLutter App',
                initialRoute:
                    state is AuthSuccess ? AppRoutes.HOME : AppRoutes.LOGIN,
                onGenerateRoute: AppRouter.onGenerateRoute,
              );
            },
          );
        },
      ),
    );
  }
}
