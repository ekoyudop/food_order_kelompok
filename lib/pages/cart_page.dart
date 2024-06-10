import 'package:flutter/material.dart';
import 'package:food_order_kelompok/components/my_button.dart';
import 'package:food_order_kelompok/components/my_cart_tile.dart';
import 'package:food_order_kelompok/models/warmindo.dart';
import 'package:food_order_kelompok/pages/payment_page.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Warmindo>(
      builder: (context, warmindo, child) {
        final userCart = warmindo.cart;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Cart"),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              // clear cart button
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text(
                            "Are you sure you want to clear your cart?"),
                        actions: [
                          // cancel button
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),

                          // yes button
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              warmindo.clearCart();
                            },
                            child: const Text("Yes"),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    userCart.isEmpty
                        ? const Expanded(
                            child: Center(
                              child: Text("Cart is Empty.."),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: userCart.length,
                              itemBuilder: (context, index) {
                                final cartItem = userCart[index];
                                return MyCartTile(
                                  cartItem: cartItem,
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
              // Checkout button
              MyButton(
                  text: "Chackout",
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PaymentPage()))),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
