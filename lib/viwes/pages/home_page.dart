import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/view_model/category_state/cubit/category_cubit.dart';
import 'package:ecommerce_app/view_model/home_state/cubit/home_cubit.dart';
import 'package:ecommerce_app/viwes/widgets/category_tab_view.dart';
import 'package:ecommerce_app/viwes/widgets/home_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit()..fetchHomeData(),
        ),
        BlocProvider<CategoryCubit>(
          create: (context) => CategoryCubit()..fetchCategories(),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: CachedNetworkImageProvider(
                            'https://as2.ftcdn.net/jpg/02/24/86/95/1000_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg',
                          ),
                        ),
                        SizedBox(width: 12),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi, Hashem Eraint',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Let\'s go shopping',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.notifications_none_outlined),
                        SizedBox(width: 16),
                        Icon(Icons.shopping_cart_outlined),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DefaultTabController(
                      length: 2,
                      child: Scaffold(
                        appBar: AppBar(
                          title: const TabBar(
                            tabs: [Tab(text: 'Home'), Tab(text: 'Category')],
                          ),
                        ),
                        body: const TabBarView(
                          children: [HomeTabView(), CategoryTabView()],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
