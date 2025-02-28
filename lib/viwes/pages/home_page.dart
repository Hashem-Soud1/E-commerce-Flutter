import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/viwes/widgets/product_item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                          backgroundImage: NetworkImage(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'New Arrivals',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'See All',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                GridView.builder(
                  itemCount: dummyProducts.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 25,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return ProductItem(productItem: dummyProducts[index]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
