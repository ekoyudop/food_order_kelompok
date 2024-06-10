import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_order_kelompok/models/food.dart';
import 'package:food_order_kelompok/pages/edit_menu_page.dart';
import 'package:food_order_kelompok/pages/food_page.dart';

class MenuPage extends StatelessWidget {
  final CollectionReference _menuCollection =
      FirebaseFirestore.instance.collection('menus');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Menus'),
      ),
      body: StreamBuilder(
        stream: _menuCollection.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot<Object?> document =
                  snapshot.data!.docs[index];
              final Food food = Food(
                name: document['name'],
                description: document['description'],
                price: document['price'],
                imagePath: document['imagePath'],
                category: FoodCategory.values.firstWhere(
                    (cat) => cat.toString() == document['category']),
                availableAddons: (document['addons'] as List<dynamic>)
                    .map((addon) => Addon(
                          name: addon['name'],
                          price: addon['price'],
                        ))
                    .toList(),
              );
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    food.imagePath,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(food.name),
                subtitle: Text(food.description),
                trailing: Text('\Rp${food.price.toStringAsFixed(3)}'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditMenuPage(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
