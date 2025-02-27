import 'package:ecommerce_app/viwes/pages/favarite_page.dart';
import 'package:ecommerce_app/viwes/pages/home_page.dart';
import 'package:ecommerce_app/viwes/pages/order_page.dart';
import 'package:ecommerce_app/viwes/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: [
        PersistentTabConfig(
          screen: HomePage(),
          item: ItemConfig(icon: Icon(Icons.home_outlined), title: "Home"),
        ),
        PersistentTabConfig(
          screen: OrderPage(),
          item: ItemConfig(
            icon: Icon(Icons.local_shipping_outlined),
            title: "My Orders",
          ),
        ),
        PersistentTabConfig(
          screen: FavaritePage(),
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
