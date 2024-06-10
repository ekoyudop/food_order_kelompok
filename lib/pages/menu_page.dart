import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_order_kelompok/components/my_current_location.dart';
import 'package:food_order_kelompok/components/my_description_box.dart';
import 'package:food_order_kelompok/components/my_drawer.dart';
import 'package:food_order_kelompok/components/my_silver_app_bar.dart';
import 'package:food_order_kelompok/components/my_tab_bar.dart';
import 'package:food_order_kelompok/models/food.dart';
import 'package:food_order_kelompok/models/warmindo.dart';
import 'package:food_order_kelompok/pages/food_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late CollectionReference _menuCollection;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: FoodCategory.values.length, vsync: this);
    _menuCollection = FirebaseFirestore.instance.collection('menus');
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

  List<Widget> getFoodInThisCategory(QuerySnapshot snapshot) {
    List<Food> fullMenu = snapshot.docs
        .map((doc) => Food(
              name: doc['name'],
              description: doc['description'],
              price: doc['price'],
              imagePath: doc['imagePath'],
              category: FoodCategory.values
                  .firstWhere((cat) => cat.toString() == doc['category']),
              availableAddons: (doc['addons'] as List<dynamic>)
                  .map((addon) => Addon(
                        name: addon['name'],
                        price: addon['price'],
                      ))
                  .toList(),
            ))
        .toList();

    return FoodCategory.values.map((category) {
      List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);
      return ListView.builder(
        itemCount: categoryMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final food = categoryMenu[index];
          return MyFoodTile(
            food: food,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FoodPage(food: food),
              ),
            ),
          );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySilverAppBar(
            title: MyTabBar(tabController: _tabController),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyCurrentLocation(),
                MyDescriptionBox(),
              ],
            ),
          ),
        ],
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
            return Consumer<Warmindo>(
              builder: (context, warmindo, child) => TabBarView(
                controller: _tabController,
                children: getFoodInThisCategory(snapshot.data!),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MyFoodTile extends StatelessWidget {
  final Food food;
  final VoidCallback onTap;

  const MyFoodTile({Key? key, required this.food, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          food.imagePath, // URL gambar dari objek Food
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(food.name),
      subtitle: Text(food.description),
      trailing: Text('\Rp${food.price.toStringAsFixed(2)}'),
      onTap: onTap,
    );
  }
}
