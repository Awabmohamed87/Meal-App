import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class FilterScreen extends StatefulWidget {
  static const routeName = '/filter';

  bool isInWelcomeScreen;
  FilterScreen({super.key, this.isInWelcomeScreen = false});

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
      body: CustomScrollView(
        slivers: [
          if (!widget.isInWelcomeScreen)
            const SliverAppBar(
              title: Text('Filters'),
            ),
          if (widget.isInWelcomeScreen)
            SliverAppBar(
              elevation: 0,
              pinned: true,
              backgroundColor: Theme.of(context).canvasColor,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                titlePadding: const EdgeInsets.only(top: 20),
                title: Text(
                  'Adjust your filters',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          SliverList(
              delegate: SliverChildListDelegate([
            const SizedBox(height: 20),
            if (!widget.isInWelcomeScreen)
              Center(
                child: Text(
                  'Adjust your filters',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            const SizedBox(height: 20),
            _createSwitchListTile(
                title: 'Gluten-Free',
                subtitle: 'Only include gluten-free meals',
                val: Provider.of<MealProvider>(context).filters['gluten']!,
                onChanged: (newVal) {
                  setState(() {
                    Provider.of<MealProvider>(context, listen: false)
                        .filters['gluten'] = newVal;
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
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
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
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
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  });
                }),
            _createSwitchListTile(
                title: 'Vegetarian',
                subtitle: 'Only include Vegetarian meals',
                val: Provider.of<MealProvider>(context).filters['vegetarian']!,
                onChanged: (newVal) {
                  setState(() {
                    Provider.of<MealProvider>(context, listen: false)
                        .filters['vegetarian'] = newVal;
                    Provider.of<MealProvider>(context, listen: false)
                        .setFilters();
                  });
                }),
            if (MediaQuery.of(context).orientation == Orientation.landscape &&
                widget.isInWelcomeScreen)
              Builder(
                  builder: (ctx) => Padding(
                        padding: const EdgeInsets.only(
                            bottom: 50.0, left: 30, right: 30, top: 20),
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context)
                              .pushReplacementNamed(TabsScreen.routeName),
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(20, 50)),
                          child: const Text('Get Started'),
                        ),
                      )),
          ]))
        ],
      ),
    );
  }
}
