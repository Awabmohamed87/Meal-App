import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';
import 'categories_screen.dart';
import 'favourites_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  static String routeName = '/tabs_screen';
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>>? _pages;
  @override
  void initState() {
    Provider.of<MealProvider>(context, listen: false).loadFilters();
    Provider.of<MealProvider>(context, listen: false).loadFavourites();
    _pages = [
      {'page': const CategoriesScreen(), 'title': 'Categories'},
      {'page': const FavouritesScreen(), 'title': 'Favourites'}
    ];
    super.initState();
  }

  int _selectedPageIndex = 0;
  void _selectPage(int value) {
    setState(() {
      _selectedPageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_pages![_selectedPageIndex]['title']}'),
        actions: _pages![_selectedPageIndex]['title'] == 'Favourites'
            ? [
                IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () =>
                        Provider.of<MealProvider>(context, listen: false)
                            .emptyFavMeals())
              ]
            : [],
      ),
      body: _pages![_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: const Color.fromRGBO(236, 236, 236, 1),
        unselectedItemColor: Colors.white,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorite"),
        ],
      ),
      drawer: const MainDrawer(),
    );
  }
}
