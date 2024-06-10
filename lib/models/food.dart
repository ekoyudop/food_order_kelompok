class Food {
  final String name;
  final double price;
  final String imagePath;
  final String description;
  final FoodCategory category;
  List<Addon> availableAddons;

  Food({
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.category,
    required this.availableAddons,
  });
}

// fod categories
enum FoodCategory {
  rices,
  noodles,
  drinks,
}

// food add ons

class Addon {
  String name;
  double price;

  Addon({
    required this.name,
    required this.price,
  });
}
