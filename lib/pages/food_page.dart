import 'package:flutter/material.dart';
import 'package:food_order_kelompok/components/button.dart';
import 'package:food_order_kelompok/components/my_button.dart';
import 'package:provider/provider.dart';

import '../models/food.dart';
import '../models/warmindo.dart';

class FoodPage extends StatefulWidget {
  final Food food;
  final Map<Addon, bool> selectedAddons = {};

  FoodPage({super.key, required this.food}) {
    for (Addon addon in food.availableAddons) {
      selectedAddons[addon] = false;
    }
  }

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  void addToCart(Food food, Map<Addon, bool> selectedAddons) {
    Navigator.pop(context);

    List<Addon> currentlySelectedAddons = [];
    for (Addon addon in widget.food.availableAddons) {
      if (widget.selectedAddons[addon] == true) {
        currentlySelectedAddons.add(addon);
      }
    }
    context.read<Warmindo>().addToCart(food, currentlySelectedAddons);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.food.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(widget.food.imagePath),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.food.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\Rp.${widget.food.price.toStringAsFixed(3)}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.food.description,
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Divider(
                    color: Colors.grey[300],
                  ),
                  Text(
                    "Add-ons",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: widget.food.availableAddons.length,
                      itemBuilder: (context, index) {
                        // get individual addon
                        Addon addon = widget.food.availableAddons[index];

                        // return a checkbox list tile for each addon
                        return CheckboxListTile(
                          title: Text(addon.name),
                          subtitle: Text(
                            '\Rp.${addon.price.toStringAsFixed(3)}',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                          value: widget.selectedAddons[addon],
                          activeColor: Color.fromARGB(255, 208, 202, 20),
                          onChanged: (bool? value) {
                            setState(
                              () {
                                widget.selectedAddons[addon] = value!;
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            MyButton(
              text: "Add to cart",
              onTap: () => addToCart(widget.food, widget.selectedAddons),
            ),
            const SizedBox(height: 20),
            Button(
              text: "Cancel",
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
