import 'package:ecommerce_app/utils/app_routes.dart';
import 'package:ecommerce_app/view_model/add_new_card_cudit/add_new_card_cubit.dart';
import 'package:ecommerce_app/view_model/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/view_model/location_page_cubit/location_page_cubit.dart';
import 'package:ecommerce_app/view_model/product_details/cubit/product_details_cubit.dart';
import 'package:ecommerce_app/viwes/pages/add_new_card_page.dart';
import 'package:ecommerce_app/viwes/pages/checkout_page.dart';
import 'package:ecommerce_app/viwes/pages/choose_location_page.dart';
import 'package:ecommerce_app/viwes/pages/custom_bottom_navbar.dart';
import 'package:ecommerce_app/viwes/pages/login_page.dart';
import 'package:ecommerce_app/viwes/pages/product_details_page.dart';
import 'package:ecommerce_app/viwes/pages/profile_page.dart';
import 'package:ecommerce_app/viwes/pages/regester_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.HOME:
        return MaterialPageRoute(builder: (_) => CustomBottomNavbar());

      case AppRoutes.PRODUCT_DETAIL:
        final productId = settings.arguments as String;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) {
                  return ProductDetailsCubit()..fetchProductDetails(productId);
                },
                child: ProductDetailsPage(productId: productId),
              ),
        );
      case AppRoutes.checkoutRoute:
        return MaterialPageRoute(
          builder: (_) => const CheckoutPage(),
          settings: settings,
        );

      case AppRoutes.LOGIN:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => AuthCubit(),
                child: const LoginPage(),
              ),
          settings: settings,
        );

      case AppRoutes.REGISTER:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => AuthCubit(),
                child: const RegisterPage(),
              ),
          settings: settings,
        );

      case AppRoutes.locationRoute:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) {
                  return ChooseLocationCubit()..fetchLocations();
                },
                child: const ChooseLocationPage(),
              ),
          settings: settings,
        );

      case AppRoutes.addNewCardRoute:
        final cubit = settings.arguments as PaymentMethodsCubit;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(value: cubit, child: AddNewCardPage()),
          settings: settings,
        );

      case AppRoutes.profileRoute:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) {
                  return AuthCubit();
                },
                child: ProfilePage(),
              ),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
