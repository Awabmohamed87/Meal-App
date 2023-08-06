import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter';

  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Widget _createSwitchListTile(
      {required String title,
      required String subtitle,
      required bool val,
      required void Function(bool) onChanged}) {
    return SwitchListTile(
      value: val,
      onChanged: onChanged,
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                Provider.of<MealProvider>(context, listen: false).setFilters();
              }),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text('Adjust your filters',
                style: Theme.of(context).textTheme.titleLarge),
          ),
          Expanded(
              child: ListView(
            children: [
              _createSwitchListTile(
                  title: 'Gluten-Free',
                  subtitle: 'Only include gluten-free meals',
                  val: Provider.of<MealProvider>(context).filters['gluten']!,
                  onChanged: (newVal) {
                    setState(() {
                      Provider.of<MealProvider>(context, listen: false)
                          .filters['gluten'] = newVal;
                    });
                  }),
              _createSwitchListTile(
                  title: 'Lactose-Free',
                  subtitle: 'Only include Lactose-free meals',
                  val: Provider.of<MealProvider>(context).filters['lactose']!,
                  onChanged: (newVal) {
                    setState(() {
                      Provider.of<MealProvider>(context, listen: false)
                          .filters['lactose'] = newVal;
                    });
                  }),
              _createSwitchListTile(
                  title: 'Vegan',
                  subtitle: 'Only include Vegan meals',
                  val: Provider.of<MealProvider>(context).filters['vegan']!,
                  onChanged: (newVal) {
                    setState(() {
                      Provider.of<MealProvider>(context, listen: false)
                          .filters['vegan'] = newVal;
                    });
                  }),
              _createSwitchListTile(
                  title: 'Vegetarian',
                  subtitle: 'Only include Vegetarian meals',
                  val:
                      Provider.of<MealProvider>(context).filters['vegetarian']!,
                  onChanged: (newVal) {
                    setState(() {
                      Provider.of<MealProvider>(context, listen: false)
                          .filters['vegetarian'] = newVal;
                    });
                  }),
            ],
          ))
        ],
      ),
      drawer: const MainDrawer(),
    );
  }
}
