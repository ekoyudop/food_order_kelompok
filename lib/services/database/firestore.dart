import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_order_kelompok/models/food.dart';

class FirestoreService {
  final CollectionReference orders =
      FirebaseFirestore.instance.collection('orders');
  final CollectionReference menus =
      FirebaseFirestore.instance.collection('menus');

  Future<void> saveOrderToDatabase(String receipt) async {
    await orders.add({
      'date': DateTime.now(),
      'order': receipt,
    });
  }

  Future<void> saveMenuToDatabase(Food food) async {
    await menus.add({
      'name': food.name,
      'description': food.description,
      'price': food.price,
      'imagePath': food.imagePath,
      'category': food.category.toString(),
      'addons': food.availableAddons
          .map((addon) => {
                'name': addon.name,
                'price': addon.price,
              })
          .toList(),
    });
  }

  Future<void> deleteMenuFromDatabase(String menuId) async {
    await menus.doc(menuId).delete();
  }

  Future<void> updateFoodInDatabase(String menuId, Food food) async {
    await menus.doc(menuId).update({
      'name': food.name,
      'description': food.description,
      'price': food.price,
      'imagePath': food.imagePath,
      'category': food.category.toString(),
      'addons': food.availableAddons
          .map((addon) => {
                'name': addon.name,
                'price': addon.price,
              })
          .toList(),
    });
  }
}
