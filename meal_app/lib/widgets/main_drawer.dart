import 'package:flutter/material.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:meal_app/screens/themes_screen.dart';
import '../screens/filter_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget buildTile(
      String title, IconData icon, Function() tapHandler, context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Theme.of(context).iconTheme.color,
      ),
      title: Text(title,
          style: const TextStyle(
              fontSize: 24,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold)),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 70,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: const Color.fromRGBO(220, 220, 220, 1),
            alignment: Alignment.centerLeft,
            child: Text(
              'Meal App',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          const SizedBox(height: 20),
          buildTile("Meal", Icons.restaurant, () {
            Navigator.of(context).pushNamed(TabsScreen.routeName);
          }, context),
          buildTile("Filter", Icons.settings, () {
            Navigator.of(context).pushNamed(FilterScreen.routeName);
          }, context),
          buildTile("Themes", Icons.color_lens, () {
            Navigator.of(context).pushNamed(ThemesScreen.routeName);
          }, context),
        ],
      ),
    );
  }
}
