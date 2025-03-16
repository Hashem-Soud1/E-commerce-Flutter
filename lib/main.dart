import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/utils/app_router.dart';
import 'package:ecommerce_app/utils/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'E-commerc FLutter App',
      initialRoute: AppRoutes.LOGIN,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
