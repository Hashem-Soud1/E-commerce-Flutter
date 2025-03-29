import 'package:ecommerce_app/view_model/cart_state/cubit/cart_cubit.dart';
import 'package:ecommerce_app/view_model/favorite_page_cubit/favorite_page_cubit.dart';
import 'package:ecommerce_app/view_model/home_state/cubit/home_cubit.dart';
import 'package:ecommerce_app/viwes/pages/favorite_page.dart';
import 'package:ecommerce_app/viwes/pages/home_page.dart';
import 'package:ecommerce_app/viwes/pages/cart_page.dart';
import 'package:ecommerce_app/viwes/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      stateManagement: false,
      tabs: [
        PersistentTabConfig(
          screen: HomePage(),
          item: ItemConfig(icon: Icon(Icons.home_outlined), title: "Home"),
        ),
        PersistentTabConfig(
          screen: BlocProvider(
            create: (context) {
              return CartCubit()..getCartItems();
            },
            child: CartPage(),
          ),
          item: ItemConfig(icon: Icon(Icons.shopping_cart), title: "Carts"),
        ),
        PersistentTabConfig(
          screen: BlocProvider(
            create: (context) => FavoriteCubit()..getFavoriteProducts(),
            child: FavoritePage(),
          ),
          item: ItemConfig(
            icon: Icon(Icons.favorite_outline),
            title: "Favarite",
          ),
        ),
        PersistentTabConfig(
          screen: ProfilePage(),
          item: ItemConfig(icon: Icon(Icons.person_outlined), title: "Profile"),
        ),
      ],
      navBarBuilder:
          (navBarConfig) => Style6BottomNavBar(navBarConfig: navBarConfig),
    );
  }
}
