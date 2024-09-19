import 'package:flutter/material.dart';
import 'database_helper.dart';

class FavoriteRecipesScreen extends StatefulWidget {
  @override
  _FavoriteRecipesScreenState createState() => _FavoriteRecipesScreenState();
}

class _FavoriteRecipesScreenState extends State<FavoriteRecipesScreen> {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  List<Map<String, dynamic>> favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites(); // Load favorite recipes when the screen is initialized
  }

  // Method to load favorite recipes from the database
  Future<void> _loadFavorites() async {
    final data = await databaseHelper.getFavorites();
    setState(() {
      favorites = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Recipes'),
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final favorite = favorites[index];
          return ListTile(
            title: Text(favorite['title']),
            leading: Image.network(favorite['image']),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                databaseHelper.deleteFavorite(favorite['id']);
                _loadFavorites(); // Reload favorite recipes after deletion
              },
            ),
          );
        },
      ),
    );
  }
}
