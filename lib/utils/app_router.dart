import 'package:ecommerce_app/utils/app_routes.dart';
import 'package:ecommerce_app/view_model/product_details/cubit/product_details_cubit.dart';
import 'package:ecommerce_app/viwes/pages/checkout_page.dart';
import 'package:ecommerce_app/viwes/pages/custom_bottom_navbar.dart';
import 'package:ecommerce_app/viwes/pages/product_details_page.dart';
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
