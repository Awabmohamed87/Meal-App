import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ThemesScreen extends StatefulWidget {
  static String routeName = '/themescreen';
  bool isInWelcomeScreen;
  ThemesScreen({super.key, this.isInWelcomeScreen = false});

  @override
  State<ThemesScreen> createState() => _ThemesScreenState();
}

class _ThemesScreenState extends State<ThemesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          if (!widget.isInWelcomeScreen)
            const SliverAppBar(
              title: Text('Themes'),
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
                  'Adjust your themes selection',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 20),
                if (!widget.isInWelcomeScreen)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Center(
                        child: Text('Adjust your themes selection',
                            style: Theme.of(context).textTheme.titleLarge)),
                  ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 5),
                  child: Text('Choose your theme mode',
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                createRadioListTile(
                    ThemeMode.system, 'System Default Theme', null, context),
                createRadioListTile(ThemeMode.light, 'Light Theme',
                    Icons.wb_sunny_outlined, context),
                createRadioListTile(ThemeMode.dark, 'Dark Theme',
                    Icons.nights_stay_outlined, context),
                ListTile(
                  title: Text('Choose your primary color',
                      style: Theme.of(context).textTheme.bodyMedium),
                  trailing: CircleAvatar(
                    backgroundColor:
                        Provider.of<ThemeProvider>(context).primaryColor,
                  ),
                  onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                          title: const Text('Pick a color!'),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: Provider.of<ThemeProvider>(context)
                                  .primaryColor,
                              onColorChanged: (newColor) =>
                                  Provider.of<ThemeProvider>(context,
                                          listen: false)
                                      .changeColor(newColor, true),
                            ),
                          ))),
                ),
                ListTile(
                  title: Text('Choose your accent color',
                      style: Theme.of(context).textTheme.bodyMedium),
                  trailing: CircleAvatar(
                    backgroundColor:
                        Provider.of<ThemeProvider>(context).accentColor,
                  ),
                  onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                          title: const Text('Pick a color!'),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: Provider.of<ThemeProvider>(context)
                                  .accentColor,
                              onColorChanged: (newColor) =>
                                  Provider.of<ThemeProvider>(context,
                                          listen: false)
                                      .changeColor(newColor, false),
                            ),
                          ))),
                ),
                if (MediaQuery.of(context).orientation ==
                        Orientation.landscape &&
                    widget.isInWelcomeScreen)
                  Builder(
                      builder: (ctx) => Padding(
                            padding: const EdgeInsets.only(
                                bottom: 50.0, left: 30, right: 30, top: 20),
                            child: ElevatedButton(
                              onPressed: () => Navigator.of(context)
                                  .pushReplacementNamed(TabsScreen.routeName),
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width * 0.9,
                                      50)),
                              child: const Text('Get Started'),
                            ),
                          )),
              ],
            ),
          )
        ],
      ),
    );
  }

  RadioListTile<dynamic> createRadioListTile(ThemeMode themeValue, String title,
          IconData? icon, BuildContext context) =>
      RadioListTile(
          secondary: Icon(icon, color: Theme.of(context).iconTheme.color),
          title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
          value: themeValue,
          groupValue: Provider.of<ThemeProvider>(context).tm,
          onChanged: (val) => Provider.of<ThemeProvider>(context, listen: false)
              .changeThemeMode(val));
}
