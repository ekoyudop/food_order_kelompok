import 'package:flutter/material.dart';
import 'package:food_order_kelompok/components/my_current_location.dart';
import 'package:food_order_kelompok/components/my_description_box.dart';
import 'package:food_order_kelompok/components/my_drawer.dart';
import 'package:food_order_kelompok/components/my_food_tile.dart';
import 'package:food_order_kelompok/components/my_silver_app_bar.dart';
import 'package:food_order_kelompok/components/my_tab_bar.dart';
import 'package:food_order_kelompok/models/food.dart';
import 'package:food_order_kelompok/models/warmindo.dart';
import 'package:food_order_kelompok/pages/food_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // TabController tabController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: FoodCategory.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // sort out and return a list of food items based on the selected category
  List<Food> _filtterMenuByCategory(
      FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

  // return list of food in given category
  List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
    return FoodCategory.values.map((category) {
      List<Food> categoryMenu = _filtterMenuByCategory(category, fullMenu);
      return ListView.builder(
        itemCount: categoryMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final food = categoryMenu[index];
          return FoodTile(
              food: food,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FoodPage(food: food))));
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
                // My current location
                MyCurrentLocation(),

                // description box
                MyDescriptionBox(),
              ],
            ),
          ),
        ],
        body: Consumer<Warmindo>(
          builder: (context, warmindo, child) => TabBarView(
            controller: _tabController,
            children: getFoodInThisCategory(warmindo.menu),
          ),
        ),
      ),
    );
  }
}
