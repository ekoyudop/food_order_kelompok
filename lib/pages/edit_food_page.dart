import 'package:flutter/material.dart';
import 'package:food_order_kelompok/models/food.dart';
import 'package:food_order_kelompok/services/database/firestore.dart';

class EditFoodPage extends StatefulWidget {
  final Food food;
  final String menuId;

  EditFoodPage({required this.food, required this.menuId});

  @override
  _EditFoodPageState createState() => _EditFoodPageState();
}

class _EditFoodPageState extends State<EditFoodPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imagePathController = TextEditingController();
  FoodCategory _selectedCategory = FoodCategory.rices;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.food.name;
    _descriptionController.text = widget.food.description;
    _priceController.text = widget.food.price.toString();
    _imagePathController.text = widget.food.imagePath;
    _selectedCategory = widget.food.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Food'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _imagePathController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<FoodCategory>(
              value: _selectedCategory,
              decoration: InputDecoration(labelText: 'Category'),
              items: FoodCategory.values.map((FoodCategory category) {
                return DropdownMenuItem<FoodCategory>(
                  value: category,
                  child: Text(category.toString().split('.').last),
                );
              }).toList(),
              onChanged: (FoodCategory? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _saveChanges(),
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveChanges() {
    final String name = _nameController.text.trim();
    final String description = _descriptionController.text.trim();
    final double price = double.tryParse(_priceController.text.trim()) ?? 0.0;
    final String imagePath = _imagePathController.text.trim();

    if (name.isNotEmpty &&
        description.isNotEmpty &&
        price > 0 &&
        imagePath.isNotEmpty) {
      final updatedFood = Food(
        name: name,
        description: description,
        price: price,
        imagePath: imagePath,
        category: _selectedCategory,
        availableAddons:
            widget.food.availableAddons, // Keeping the original addons
      );
      // Here you can call your FirestoreService to update the food item
      // For example:
      final FirestoreService _firestoreService = FirestoreService();
      _firestoreService.updateFoodInDatabase(widget.menuId, updatedFood);

      // After updating, you might want to navigate back to the previous page
      Navigator.pop(context);
    } else {
      // Show error message if any field is empty or price is not valid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields correctly.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
