import 'package:flutter/material.dart';
import 'package:food_order_kelompok/components/my_drawer_tile.dart';
import 'package:food_order_kelompok/services/auth/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // app image
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Image.asset(
              'assets/logo.png',
              height: 100,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          // home list tile
          MyDrawerTile(
              text: "H O M E",
              icon: Icons.home,
              onTap: () => Navigator.pop(context)),

          // settings list tile
          MyDrawerTile(
              text: "S E T T I N G S",
              icon: Icons.settings,
              onTap: () => {
                    Navigator.pop(context),
                    Navigator.pushNamed(context, '/settings')
                  }),

          const Spacer(),

          // logout list tile
          MyDrawerTile(
            text: "L O G O U T",
            icon: Icons.logout,
            onTap: () {
              logout();
              Navigator.pop(context);
              Navigator.pushNamed(context, '/loginpage');
            },
          ),

          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
