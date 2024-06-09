import 'package:flutter/material.dart';

class MyCurrentLocation extends StatelessWidget {
  const MyCurrentLocation({super.key});

  void openLocationSearchBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Your Location"),
        content: const TextField(
          decoration: InputDecoration(
            hintText: "Enter your location",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Location",
            style: TextStyle(
                color: Color.fromARGB(255, 165, 164, 164),
                fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () => openLocationSearchBox(context),
            child: Row(
              children: [
                // address
                Text(
                  "Karang Pucung",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 125, 125, 125),
                      fontWeight: FontWeight.bold),
                ),

                // icon
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
