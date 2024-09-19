import 'package:flutter/material.dart';
import 'recipe_list_screen.dart';
import 'favorite_recipes_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0; // Variable to keep track of the selected tab

  // List of widgets to display in the bottom navigation bar
  static final List<Widget> _widgetOptions = <Widget>[
    RecipeListScreen(),
    FavoriteRecipesScreen(),
  ];

  // Method to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe App'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex), // Display the selected widget
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: _selectedIndex, // Current selected tab
        onTap: _onItemTapped, // Method to handle tab selection
      ),
    );
  }
}
