import 'package:flutter/material.dart';
import 'package:meal_app/screens/filter_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:meal_app/screens/themes_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('Images/image.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  height: 100,
                  width: 20,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(10, 10, 10, 0.4)),
                  child: Center(
                    child: Text(
                      'Ready to cook some things up..!!',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
              FilterScreen(isInWelcomeScreen: true),
              ThemesScreen(isInWelcomeScreen: true)
            ],
            onPageChanged: (val) {
              setState(() {
                _selectedPage = val;
              });
            },
          ),
          if (MediaQuery.of(context).orientation == Orientation.portrait)
            Builder(
                builder: (ctx) => Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.06),
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context)
                            .pushReplacementNamed(TabsScreen.routeName),
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.9, 50)),
                        child: const Text('Get Started'),
                      ),
                    )),
          Indicator(_selectedPage)
        ],
      ),
    );
  }
}

class Indicator extends StatefulWidget {
  final int selectedPage;

  const Indicator(this.selectedPage, {super.key});

  @override
  State<StatefulWidget> createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  Widget _createButton(index) {
    return Icon(index == widget.selectedPage ? Icons.star : Icons.circle,
        size: index == widget.selectedPage ? 20 : 14);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_createButton(0), _createButton(1), _createButton(2)],
      ),
    );
  }
}
