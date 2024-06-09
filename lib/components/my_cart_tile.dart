import 'package:flutter/material.dart';
import 'package:food_order_kelompok/components/my_quantity_selector.dart';
import 'package:provider/provider.dart';

import '../models/card_items.dart';
import '../models/warmindo.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;
  const MyCartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<Warmindo>(
      builder: (context, warmindo, child) => Container(
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // food image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      cartItem.food.imagePath,
                      height: 100,
                      width: 100,
                    ),
                  ),

                  const SizedBox(width: 10),

                  // name and price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // food name
                      Text(
                        cartItem.food.name,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),

                      // food price
                      Text(
                        '\Rp.${cartItem.food.price.toStringAsFixed(3)}',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 146, 144, 144),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // increment and decrement quantity
                  QuantitySelector(
                      quantity: cartItem.quantity,
                      food: cartItem.food,
                      onDecrement: () {
                        warmindo.removeFromCart(cartItem);
                      },
                      onIncrement: () {
                        warmindo.addToCart(
                            cartItem.food, cartItem.selectedAddons);
                      }),
                ],
              ),
            ),

            // addons
            SizedBox(
              height: cartItem.selectedAddons.isEmpty ? 0 : 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                children: cartItem.selectedAddons
                    .map(
                      (addon) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          label: Row(
                            children: [
                              // addon name
                              Text(
                                addon.name,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 47, 47, 47),
                                ),
                              ),

                              // addon price
                              Text(
                                ' (\Rp.${addon.price.toStringAsFixed(3)})',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 47, 47, 47),
                                ),
                              ),
                            ],
                          ),
                          shape: StadiumBorder(
                            side: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          onSelected: (value) {},
                          backgroundColor: Colors.white,
                          labelStyle: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
