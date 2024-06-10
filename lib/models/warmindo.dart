import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:food_order_kelompok/models/card_items.dart';
import 'package:intl/intl.dart';

import 'food.dart';

class Warmindo extends ChangeNotifier {
  // list of food menu
  final List<Food> _menu = [
    // mie
    Food(
      name: "Magelangan",
      description:
          "Mie yang diolah dengan bumbu indomie dan ditambahkan dengan telur dan nasi.",
      price: 12.0000,
      imagePath: "assets/mie/magelangan.jpg",
      category: FoodCategory.noodles,
      availableAddons: [
        Addon(name: "Double Mie", price: 5.000),
        Addon(name: "Telur", price: 5.000),
        Addon(name: "Nasi", price: 3.000),
        Addon(name: "Kerupuk", price: 2.000)
      ],
    ),

    Food(
      name: "Mie Kuah",
      description:
          "Mie indomie disajikan dengan kuah yang gurih dan ditambahkan dengan telur saat cuaca dingin.",
      price: 10.0000,
      imagePath: "assets/mie/Mie_Kuah.jpg",
      category: FoodCategory.noodles,
      availableAddons: [
        Addon(name: "Double Mie", price: 5.000),
        Addon(name: "Telur", price: 5.000),
        Addon(name: "Nasi", price: 3.000),
        Addon(name: "Kerupuk", price: 2.000)
      ],
    ),

    Food(
      name: "Mie Goreng",
      description:
          "Indomie Goreng yang diolah dengan bumbu indomie dan ditambahkan dengan telur.",
      price: 10.0000,
      imagePath: "assets/mie/indomie.png",
      category: FoodCategory.noodles,
      availableAddons: [
        Addon(name: "Double Mie", price: 5.000),
        Addon(name: "Telur", price: 5.000),
        Addon(name: "Nasi", price: 3.000),
        Addon(name: "Kerupuk", price: 2.000)
      ],
    ),

    Food(
      name: "Mie Nyemek",
      description:
          "Hidangan ini biasanya terbuat dari mie instan atau mie telur yang dimasak dengan campuran bumbu-bumbu seperti bawang putih, cabai, kecap manis, dan saus sambal. Ditambahkan dengan sayuran, telur, dan terkadang daging ayam atau udang, mie nyemek memberikan rasa yang gurih dan sedikit pedas.",
      price: 20.000,
      imagePath: "assets/mie/Mie_nyemek.jpg",
      category: FoodCategory.noodles,
      availableAddons: [
        Addon(name: "Double Mie", price: 5.000),
        Addon(name: "Telur", price: 5.000),
        Addon(name: "Nasi", price: 3.000),
        Addon(name: "Kerupuk", price: 2.000)
      ],
    ),

    Food(
      name: "Mie Setan",
      description:
          "Mie Setan adalah makanan khas Indonesia yang terbuat dari mie instan yang dimasak dengan bumbu pedas dan ditambahkan dengan telur dan nasi.",
      price: 18.0000,
      imagePath: "assets/mie/Pedes.jpg",
      category: FoodCategory.noodles,
      availableAddons: [
        Addon(name: "Double Mie", price: 5.000),
        Addon(name: "Telur", price: 5.000),
        Addon(name: "Nasi", price: 3.000),
        Addon(name: "Kerupuk", price: 2.000)
      ],
    ),

    Food(
      name: "Mie Aceh",
      description:
          "Mie Aceh adalah makanan khas Aceh yang terbuat dari mie kuning yang dimasak dengan bumbu kari dan ditambahkan dengan telur dan nasi.",
      price: 20.0000,
      imagePath: "assets/mie/mie_rebus_cabe.jpg",
      category: FoodCategory.noodles,
      availableAddons: [
        Addon(name: "Double Mie", price: 5.000),
        Addon(name: "Telur", price: 5.000),
        Addon(name: "Nasi", price: 3.000),
        Addon(name: "Kerupuk", price: 2.000)
      ],
    ),

    // nasi
    Food(
      name: "Ayam Geprek",
      description:
          "Hidangan ini terkenal karena rasa pedasnya yang menggugah selera dan sering disajikan dengan nasi putih hangat, lalapan, dan terkadang tambahan seperti keju leleh. Ayam geprek populer sebagai makanan cepat saji yang lezat dan memuaskan.",
      price: 15.0000,
      imagePath: "assets/nasi/ayam_geprek.jpg",
      category: FoodCategory.rices,
      availableAddons: [
        Addon(name: "Ayam", price: 5.000),
        Addon(name: "Mozarella", price: 5.000),
        Addon(name: "Nasi", price: 3.000),
        Addon(name: "Kerupuk", price: 2.000)
      ],
    ),

    Food(
      name: "Nasi Goreng",
      description:
          "Nasi goreng adalah makanan khas Indonesia yang terbuat dari nasi putih yang digoreng dengan bumbu-bumbu seperti bawang putih, bawang merah, cabai, dan kecap manis. Nasi goreng sering disajikan dengan telur mata sapi, irisan mentimun, dan kerupuk.",
      price: 16.0000,
      imagePath: "assets/nasi/nasi_goreng.jpg",
      category: FoodCategory.rices,
      availableAddons: [
        Addon(name: "Ayam", price: 5.000),
        Addon(name: "Telur", price: 5.000),
        Addon(name: "Nasi", price: 3.000),
        Addon(name: "Kerupuk", price: 2.000),
        Addon(name: "Sosis", price: 5.000)
      ],
    ),

    Food(
      name: "Nasi Gila",
      description:
          "Nasi gila adalah makanan khas Indonesia yang terbuat dari nasi putih yang digoreng dengan bumbu-bumbu seperti bawang putih, bawang merah, cabai, dan kecap manis. Nasi gila sering disajikan dengan telur mata sapi, irisan mentimun, dan kerupuk.",
      price: 18.0000,
      imagePath: "assets/nasi/nasi_gila.jpg",
      category: FoodCategory.rices,
      availableAddons: [
        Addon(name: "Ayam", price: 5.000),
        Addon(name: "Telur", price: 5.000),
        Addon(name: "Nasi", price: 3.000),
        Addon(name: "Kerupuk", price: 2.000),
        Addon(name: "Sosis", price: 5.000)
      ],
    ),

    Food(
      name: "Orak Arik",
      description:
          "Orak Arik adalah makanan khas Indonesia yang terbuat dari telur yang diaduk dengan bumbu-bumbu seperti bawang putih, bawang merah, cabai, dan kecap manis. Orak Arik sering disajikan dengan nasi putih hangat.",
      price: 12.0000,
      imagePath: "assets/nasi/orak_arik.jpg",
      category: FoodCategory.rices,
      availableAddons: [
        Addon(name: "Ayam", price: 5.000),
        Addon(name: "Telur", price: 5.000),
        Addon(name: "Nasi", price: 3.000),
        Addon(name: "Kerupuk", price: 2.000),
        Addon(name: "Sosis", price: 5.000)
      ],
    ),

    Food(
      name: "Nasi Uduk",
      description:
          "Nasi uduk adalah makanan khas Indonesia yang terbuat dari nasi putih yang dimasak dengan santan dan rempah-rempah. Nasi uduk sering disajikan dengan telur, ayam goreng, tempe, dan sambal terasi.",
      price: 20.0000,
      imagePath: "assets/nasi/nasi_uduk.jpg",
      category: FoodCategory.rices,
      availableAddons: [
        Addon(name: "Ayam", price: 5.000),
        Addon(name: "Telur", price: 5.000),
        Addon(name: "Nasi", price: 3.000),
        Addon(name: "Kerupuk", price: 2.000),
        Addon(name: "Sosis", price: 5.000)
      ],
    ),

    // minuman
    Food(
      name: "Cappucino",
      description: "Minuman kopi yang terbuat dari espresso dan susu.",
      price: 5.0000,
      imagePath: "assets/minuman/Cappuccino.jpg",
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "Susu", price: 2.000),
        Addon(name: "Krim", price: 2.000),
      ],
    ),

    Food(
      name: "Es Teh",
      description: "Minuman teh yang disajikan dingin dengan es.",
      price: 3.0000,
      imagePath: "assets/minuman/es_teh.jpg",
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "Susu", price: 2.000),
        Addon(name: "Krim", price: 2.000),
      ],
    ),

    Food(
      name: "Teh Tarik",
      description: "Minuman teh yang disajikan dengan susu dan gula.",
      price: 5.0000,
      imagePath: "assets/minuman/teh_tarik.jpg",
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "Susu", price: 2.000),
        Addon(name: "Krim", price: 2.000),
      ],
    ),

    Food(
      name: "Es Jeruk",
      description: "Minuman jeruk yang disajikan dingin dengan es.",
      price: 5.0000,
      imagePath: "assets/minuman/es_jeruk.jpg",
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "Susu", price: 2.000),
        Addon(name: "Krim", price: 2.000),
      ],
    ),

    Food(
      name: "Capcin",
      description: "Minuman kopi yang disajikan dengan susu dan gula.",
      price: 5.0000,
      imagePath: "assets/minuman/kopi.jpg",
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "Susu", price: 2.000),
        Addon(name: "Krim", price: 2.000),
        Addon(name: "Cincau", price: 1.000)
      ],
    ),
  ];

  //Getter for menu

  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;

  //end getter for menu

  /* 
  
    Operation

  */

  final List<CartItem> _cart = [];

  // add to cart
  void addToCart(Food food, List<Addon> selectedAddons) {
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      bool isSameFood = item.food == food;

      bool isSameAddons =
          ListEquality().equals(item.selectedAddons, selectedAddons);

      return isSameFood && isSameAddons;
    });

    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(
        CartItem(
          food: food,
          selectedAddons: selectedAddons,
        ),
      );
    }
    notifyListeners();
  }

  // remove from cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
      notifyListeners();
    }
  }

  // get total price of cart
  double getTotalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;

      for (Addon addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }

      total += itemTotal * cartItem.quantity;
    }
    return total;
  }

  // get total number of items in cart
  int getTotalItemCount() {
    int totalItemCount = 0;

    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }

    return totalItemCount;
  }

  // clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  /*
    
      Helppers
  
  */

  // generate a receipt
  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln('Struk Pesanan Anda di Warung Makan Warmindo');
    receipt.writeln();

    // format the date to include up to second only
    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("-----------------------");

    for (final cartItem in _cart) {
      receipt.writeln(
          "${cartItem.quantity} x ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}");
      if (cartItem.selectedAddons.isNotEmpty) {
        receipt.writeln(" Add-ons: ${_formatAddons(cartItem.selectedAddons)}");
      }
      receipt.writeln();
    }
    receipt.writeln("-----------------------");
    receipt.writeln();
    receipt.writeln("Total Items: ${getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");

    return receipt.toString();
  }

  // format double value into money
  String _formatPrice(double price) {
    return '\Rp.${price.toStringAsFixed(3)}';
  }

  // format list of addons into string summary
  String _formatAddons(List<Addon> addons) {
    return addons
        .map((addons) => '${addons.name} (${_formatPrice(addons.price)})')
        .join(', ');
  }
}
