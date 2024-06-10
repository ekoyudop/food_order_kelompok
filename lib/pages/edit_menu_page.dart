import 'package:flutter/material.dart';
import 'package:food_order_kelompok/models/food.dart';
import '../services/database/firestore.dart';

class EditMenuPage extends StatefulWidget {
  @override
  _EditMenuPageState createState() => _EditMenuPageState();
}

class _EditMenuPageState extends State<EditMenuPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imagePathController = TextEditingController();

  String _selectedCategory =
      FoodCategory.drinks.toString(); // Default to drinks
  List<String> _categories = [
    FoodCategory.drinks.toString(),
    FoodCategory.noodles.toString(),
    FoodCategory.rices.toString(),
  ];

  List<Addon> _addons = [];

  final FirestoreService _firestoreService = FirestoreService();

  void _setImageFromUrl(String url) {
    setState(() {
      _imagePathController.text = url;
    });
  }

  void _addAddon(String name, double price) {
    setState(() {
      _addons.add(Addon(name: name, price: price));
    });
  }

  void _removeAddon(int index) {
    setState(() {
      _addons.removeAt(index);
    });
  }

  void _submitMenu() {
    String name = _nameController.text;
    String description = _descriptionController.text;
    double price = double.parse(_priceController.text);
    String imagePath = _imagePathController.text;
    FoodCategory category = FoodCategory.values
        .firstWhere((element) => element.toString() == _selectedCategory);

    Food newFood = Food(
      name: name,
      description: description,
      price: price,
      imagePath: imagePath,
      category: category,
      availableAddons: _addons,
    );

    _firestoreService.saveMenuToDatabase(newFood);

    _nameController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _imagePathController.clear();
    setState(() {
      _addons.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Menu'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _imagePathController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            DropdownButtonFormField(
              value: _selectedCategory,
              items: _categories.map((String category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
              decoration: InputDecoration(labelText: 'Category'),
            ),
            SizedBox(height: 16.0),
            Text('Available Addons:'),
            SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _addons.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_addons[index].name),
                  subtitle:
                      Text('\Rp${_addons[index].price.toStringAsFixed(3)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () => _removeAddon(index),
                  ),
                );
              },
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Add Addon'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Addon Name'),
                            onFieldSubmitted: (value) {
                              if (value.isNotEmpty) {
                                Navigator.of(context).pop();
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Add Addon Price'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                labelText: 'Addon Price'),
                                            onFieldSubmitted: (price) {
                                              if (price.isNotEmpty) {
                                                _addAddon(
                                                    value, double.parse(price));
                                                Navigator.of(context).pop();
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Text('Add Addon'),
            ),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: _submitMenu,
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
