import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_order_kelompok/models/food.dart';
import 'package:food_order_kelompok/pages/food_page.dart';
import 'package:food_order_kelompok/services/database/firestore.dart';
import 'package:food_order_kelompok/pages/edit_food_page.dart';

class MenuPage extends StatelessWidget {
  final CollectionReference _menuCollection =
      FirebaseFirestore.instance.collection('menus');
  final FirestoreService _firestoreService = FirestoreService();

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
              final DocumentSnapshot document = snapshot.data!.docs[index];
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
                trailing: PopupMenuButton<String>(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: ListTile(
                        leading: Icon(Icons.edit),
                        title: Text('Edit'),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: ListTile(
                        leading: Icon(Icons.delete),
                        title: Text('Delete'),
                      ),
                    ),
                  ],
                  onSelected: (String value) {
                    if (value == 'edit') {
                      _editFood(context, food, document.id);
                    } else if (value == 'delete') {
                      _confirmDelete(context, document.id);
                    }
                  },
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodPage(food: food),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _editFood(BuildContext context, Food food, String menuId) {
    // Navigasi ke halaman edit makanan sambil melewatkan data makanan yang akan diedit
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditFoodPage(food: food, menuId: menuId), // Passing menuId
      ),
    );
  }

  void _confirmDelete(BuildContext context, String menuId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: Text('Are you sure you want to delete this menu?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close dialog
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteFood(context, menuId); // Call delete function
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteFood(BuildContext context, String menuId) {
    _firestoreService.deleteMenuFromDatabase(menuId);
  }
}
