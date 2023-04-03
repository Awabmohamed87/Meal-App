import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter';
  final Function saveFilters;
  final Map<String, bool> _filtersState;

  FilterScreen(this._filtersState, this.saveFilters);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;

  @override
  initState() {
    _isGlutenFree = widget._filtersState['gluten'];
    _isLactoseFree = widget._filtersState['lactose'];
    _isVegan = widget._filtersState['vegan'];
    _isVegetarian = widget._filtersState['vegetarian'];
    super.initState();
  }

  Widget _createSwitchListTile(
      String title, String subtitle, bool _val, Function onChanged) {
    return SwitchListTile(
      value: _val,
      onChanged: onChanged,
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                widget.saveFilters({
                  'gluten': _isGlutenFree,
                  'lactose': _isLactoseFree,
                  'vegan': _isVegan,
                  'vegetarian': _isVegetarian
                });
              }),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text('Adjust your filters',
                style: Theme.of(context).textTheme.headline6),
          ),
          Expanded(
              child: ListView(
            children: [
              _createSwitchListTile('Gluten-Free',
                  'Only include gluten-free meals', _isGlutenFree, (newVal) {
                setState(() {
                  _isGlutenFree = newVal;
                });
              }),
              _createSwitchListTile('Lactose-Free',
                  'Only include Lactose-free meals', _isLactoseFree, (newVal) {
                setState(() {
                  _isLactoseFree = newVal;
                });
              }),
              _createSwitchListTile(
                  'Vegan', 'Only include Vegan meals', _isVegan, (newVal) {
                setState(() {
                  _isVegan = newVal;
                });
              }),
              _createSwitchListTile(
                  'Vegetarian', 'Only include Vegetarian meals', _isVegetarian,
                  (newVal) {
                setState(() {
                  _isVegetarian = newVal;
                });
              }),
            ],
          ))
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
